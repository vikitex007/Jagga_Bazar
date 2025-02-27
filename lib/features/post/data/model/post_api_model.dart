import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/post_entity.dart';

part 'post_api_model.g.dart';
@JsonSerializable()
class PostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? postId;
  final String title;
  final String description;
  final String price;
  final String location;
  final String? image;
  final bool negotiable;
  final String ?  postedBy;
  final String ? createdAt;

  const PostApiModel({
    this.postId,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    required this.location,
    required this.negotiable,
    required this.postedBy,
    required this.createdAt,
  });

  const PostApiModel.empty()
      : postId = null,
        title = '',
        description = '',
        price = '',
        image = null,
        location = '',
        negotiable = true,
        postedBy = '',
        createdAt = '';

  // From JSON (manually written)
  factory PostApiModel.fromJson(Map<String, dynamic> json) {
    return PostApiModel(
      postId: json['_id'] as String?,
      title: json['title'] as String? ?? '', // Handle null values by providing a default empty string
      location: json['location'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '',
      image: json['image'] as String? ?? '',
      negotiable: json['negotiable'] as bool? ?? false, // Default to false if null
      postedBy: json['postedBy'] as String? ?? '', // Default to empty string if null
      createdAt: json['createdAt'] as String? ?? '', // Default to empty string if null
    );
  }

  // To JSON (manually written)
  Map<String, dynamic> toJson() {
    return {
      '_id': postId,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'image': image,
      'negotiable': negotiable,
      'postedBy': postedBy,
      'createdAt': createdAt,
    };
  }

  // Convert API Object to Entity
  PostEntity toEntity() => PostEntity(
    id: postId,
    title: title,
    description: description,
    price: price,
    image: image,
    location: location,
    negotiable: negotiable,
    postedBy: postedBy,
    createdAt: createdAt,
  );

  // Convert Entity to API Object
  static PostApiModel fromEntity(PostEntity entity) => PostApiModel(
    postId: entity.id,
    title: entity.title,
    description: entity.description,
    location: entity.location,
    price: entity.price,
    image: entity.image,
    negotiable: entity.negotiable,
    postedBy: entity.postedBy,
    createdAt: entity.createdAt,
  );

  // Convert API List to Entity List
  static List<PostEntity> toEntityList(List<PostApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
    postId,
    title,
    description,
    location,
    price,
    image,
    negotiable,
    postedBy,
    createdAt,
  ];
}

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/post_entity.dart';

part 'post_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.postTableId)
class PostHiveModel extends Equatable {
  @HiveField(0)
  final String? postId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final String? image;

  @HiveField(5)
  final bool negotiable;

  @HiveField(6)
  final String postedBy;

  @HiveField(7)
  final String createdAt;

  PostHiveModel({
    String? postId,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.negotiable = true,
    required this.postedBy,
    String? createdAt,
  })  : postId = postId ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now().toIso8601String();

  // Initial Constructor
  const PostHiveModel.initial()
      : postId = '',
        title = '',
        description = '',
        price = '',
        image = '',
        negotiable = true,
        postedBy = '',
        createdAt = '';

  // From Entity
  factory PostHiveModel.fromEntity(PostEntity entity) {
    return PostHiveModel(
      postId: entity.id,
      title: entity.title,
      description: entity.description,
      price: entity.price,
      image: entity.image,
      negotiable: entity.negotiable,
      postedBy: entity.postedBy,
      createdAt: entity.createdAt,
    );
  }

  // To Entity
  PostEntity toEntity() {
    return PostEntity(
      id: postId,
      title: title,
      description: description,
      price: price,
      image: image,
      negotiable: negotiable,
      postedBy: postedBy,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [postId, title, description, price, image, negotiable, postedBy, createdAt];

  // From Entity List
  static List<PostHiveModel> fromEntityList(List<PostEntity> entityList) {
    return entityList.map((entity) => PostHiveModel.fromEntity(entity)).toList();
  }

  // To Entity List
  static List<PostEntity> toEntityList(List<PostHiveModel> hiveList) {
    return hiveList.map((hive) => hive.toEntity()).toList();
  }
}

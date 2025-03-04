import 'package:equatable/equatable.dart';

import '../../../post/domain/entity/post_entity.dart';

class FavouritePostEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String? image;
  final bool negotiable;

  const FavouritePostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    this.image,
    required this.negotiable,
  });

  /// Factory method to convert `PostEntity` to `FavouritePostEntity`
  factory FavouritePostEntity.fromPostEntity(PostEntity post) {
    return FavouritePostEntity(
      id: post.id ?? '', // Handle null case if ID is optional
      title: post.title,
      description: post.description,
      price: post.price,
      location: post.location,
      image: post.image,
      negotiable: post.negotiable,
    );
  }

  PostEntity toPostEntity() {
    return PostEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      location: location,
      image: image,
      negotiable: negotiable,
    );
  }

  @override
  List<Object?> get props => [id, title, description, price, location, image, negotiable];
}

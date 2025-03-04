import 'package:hive/hive.dart';
import '../../domain/entity/favourite_post_entity.dart';

part 'favourite_post_model.g.dart'; // Don't forget to run `flutter packages pub run build_runner build`

@HiveType(typeId: 2) // Make sure this typeId is unique across your app
class FavouritePostModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String? image;

  @HiveField(6)
  final bool negotiable;

  FavouritePostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    this.image,
    required this.negotiable,
  });

  /// Convert model to entity
  FavouritePostEntity toEntity() {
    return FavouritePostEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      location: location,
      image: image,
      negotiable: negotiable,
    );
  }

  /// Convert entity to model
  factory FavouritePostModel.fromEntity(FavouritePostEntity entity) {
    return FavouritePostModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      price: entity.price,
      location: entity.location,
      image: entity.image,
      negotiable: entity.negotiable,
    );
  }
}

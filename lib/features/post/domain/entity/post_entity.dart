import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String price;
  final String? image;
  final bool negotiable;
  final String postedBy;
  final String createdAt; // Store DateTime as a String

  const PostEntity({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.negotiable = true,
    required this.postedBy,
    required this.createdAt,
  }) ;// Convert DateTime to String

  @override
  List<Object?> get props =>
      [id, title, description, price, image, negotiable, postedBy, createdAt];
}

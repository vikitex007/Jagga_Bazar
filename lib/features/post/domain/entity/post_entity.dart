import 'package:equatable/equatable.dart';


class PostEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String? image;
  final bool negotiable;
  final String? postedBy;
  final String? createdAt; // Store DateTime as a String

  const PostEntity({
    this.id,
    required this.location,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.negotiable = true,
     this.postedBy,
     this.createdAt,
  }) ;// Convert DateTime to String

  @override
  List<Object?> get props =>
      [id, title, description, price,location, image, negotiable, postedBy, createdAt];
}

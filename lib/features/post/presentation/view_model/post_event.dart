part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class LoadPosts extends PostEvent {}

final class AddPost extends PostEvent {
  final String title;
  final String description;
  final String price;
  final String? image;
  final bool negotiable;
  final String postedBy;
  final String? createdAt;

  const AddPost({
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.negotiable = true,
    required this.postedBy,
    this.createdAt,
  });

  @override
  List<Object> get props => [title, description, price, image ?? '', negotiable, postedBy, createdAt ?? ''];
}

final class DeletePost extends PostEvent {
  final String postId;

  const DeletePost(this.postId);

  @override
  List<Object> get props => [postId];
}

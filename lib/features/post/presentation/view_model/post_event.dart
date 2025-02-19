part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class           LoadPosts extends PostEvent {}

class LoadImage extends PostEvent{
  final File file;
  const LoadImage({
    required this.file,
  });
}


final class AddPost extends PostEvent {
  final String title;
  final String description;
  final String price;
  final String? image;
  final bool negotiable;
  final String location;
  final String? postedBy;
  final String? createdAt;

  const AddPost({
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    this.image,
    this.negotiable = true,
    this.postedBy,
    this.createdAt,
  });

  @override
  List<Object> get props => [title, description, price, image ?? '', negotiable, postedBy?? '',location, createdAt ?? ''];
}

final class DeletePost extends PostEvent {
  final String postId;

  const DeletePost(this.postId);

  @override
  List<Object> get props => [postId];
}

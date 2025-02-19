part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostEntity> posts;
  final bool isLoading;
  final String? error;
  final String? imageName;

  const PostState({
    required this.posts,
    required this.isLoading,
    this.error,
    this.imageName,
  });

  factory PostState.initial() {
    return PostState(
      posts: [],
      isLoading: false,
      error: null, // Default null value for error
    );
  }

  PostState copyWith({
    List<PostEntity>? posts,
    bool? isLoading,
    String? error,
    String? imageName
  }) {
    return PostState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      imageName: imageName,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    isLoading,
    error ?? '',
    imageName// If error is null, use an empty string as default
  ];
}

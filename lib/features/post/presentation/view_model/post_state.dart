part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostEntity> posts;
  final bool isLoading;
  final String? error;

  const PostState({
    required this.posts,
    required this.isLoading,
    this.error,
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
  }) {
    return PostState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    isLoading,
    error ?? '', // If error is null, use an empty string as default
  ];
}

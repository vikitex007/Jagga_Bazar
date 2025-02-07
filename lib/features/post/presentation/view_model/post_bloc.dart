import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


import '../../domain/entity/post_entity.dart';
import '../../domain/use_case/create_post_usecase.dart';
import '../../domain/use_case/delete_post_usecase.dart';
import '../../domain/use_case/get_all_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPostUseCase;
  final GetAllPostUseCase _getAllPostUseCase;
  final DeletePostUseCase _deletePostUseCase;

  PostBloc({
    required CreatePostUseCase createPostUseCase,
    required GetAllPostUseCase getAllPostUseCase,
    required DeletePostUseCase deletePostUseCase,
  })  : _createPostUseCase = createPostUseCase,
        _getAllPostUseCase = getAllPostUseCase,
        _deletePostUseCase = deletePostUseCase,
        super(PostState.initial()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);

    // Uncomment to load posts initially when the bloc is created
    // add(LoadPosts());
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllPostUseCase.call();
    result.fold(
          (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
          (posts) {
        emit(state.copyWith(isLoading: false, posts: posts));
      },
    );
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createPostUseCase.call(CreatePostParams(
      title: event.title,
      description: event.description,
      price: event.price,
      image: event.image,
      negotiable: event.negotiable,
      postedBy: event.postedBy,
      createdAt: event.createdAt,
    ));
    result.fold(
          (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
          (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadPosts());
      },
    );
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deletePostUseCase.call(DeletePostParams(postId: event.postId));
    result.fold(
          (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
          (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadPosts());
      },
    );
  }
}

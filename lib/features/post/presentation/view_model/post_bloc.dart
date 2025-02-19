import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';



import '../../domain/entity/post_entity.dart';
import '../../domain/use_case/create_post_usecase.dart';
import '../../domain/use_case/delete_post_usecase.dart';
import '../../domain/use_case/get_all_post_usecase.dart';
import '../../domain/use_case/upload_image_usecase.dart';


part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPostUseCase;
  final GetAllPostUseCase _getAllPostUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  PostBloc({
    required CreatePostUseCase createPostUseCase,
    required GetAllPostUseCase getAllPostUseCase,
    required DeletePostUseCase deletePostUseCase,
    required UploadImageUseCase uploadImageUseCase,

  })  : _createPostUseCase = createPostUseCase,
        _getAllPostUseCase = getAllPostUseCase,
        _deletePostUseCase = deletePostUseCase,
        _uploadImageUseCase = uploadImageUseCase,
        super(PostState.initial()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);
    on<LoadImage>(_onLoadImage);

    // Uncomment to load posts initially when the bloc is created
    add(LoadPosts());
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
      location: event.location,
      image: event.image,
      negotiable: event.negotiable,
      postedBy: 'user',
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
  void _onLoadImage(
      LoadImage event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUseCase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
          (l) => emit(state.copyWith(isLoading: false, error: 'false')),
          (r) {
        emit(state.copyWith(isLoading: false, error: '', imageName: r));
      },
    );
  }
}

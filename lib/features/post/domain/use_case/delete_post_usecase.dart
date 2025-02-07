import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/post_repository.dart';

class DeletePostParams extends Equatable {
  final String postId;

  const DeletePostParams({required this.postId});

  const DeletePostParams.empty() : postId = '_empty.string';

  @override
  List<Object?> get props => [
    postId,
  ];
}

class DeletePostUseCase implements UsecaseWithParams<void, DeletePostParams> {
  final IPostRepository postRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeletePostUseCase({
    required this.postRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeletePostParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l); // Return failure if token retrieval fails
    }, (r) async {
      // Call the repository to delete the post with the given postId
      return await postRepository.deletePost(params.postId, r);
    });
  }
}

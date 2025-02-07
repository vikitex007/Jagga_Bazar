import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

class GetAllPostUseCase implements UsecaseWithoutParams<List<PostEntity>> {
  final IPostRepository postRepository;

  GetAllPostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, List<PostEntity>>> call() {
    return postRepository.getPosts();
  }
}

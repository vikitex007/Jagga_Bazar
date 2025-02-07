import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../data_source/remotedatasource/post_remote_datasource.dart';

class PostRemoteRepository implements IPostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createPost(PostEntity post) async {
    try {
      await remoteDataSource.createPost(post);
      return Right(null);  // Return success with null
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    try {
      final posts = await remoteDataSource.getPosts();
      return Right(posts);  // Return posts
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId, String? token) async {
    try {
      await remoteDataSource.deletePost(postId, token);  // Pass both postId and token
      return Right(null);  // Return success with null
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(PostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}

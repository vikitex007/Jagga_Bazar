import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../data_source/localdatasource/post_local_datasource.dart';

class PostLocalRepository implements IPostRepository {
  final PostLocalDataSource _postLocalDataSource;

  PostLocalRepository({required PostLocalDataSource postLocalDataSource})
      : _postLocalDataSource = postLocalDataSource;

  @override
  Future<Either<Failure, void>> createPost(PostEntity post) {
    try {
      _postLocalDataSource.createPost(post);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String id, String? token) {
    try {
      _postLocalDataSource.deletePost(id, token);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() {
    try {
      return _postLocalDataSource.getPosts().then(
            (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(PostEntity post) {
    try {
      _postLocalDataSource.updatePost(post);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}

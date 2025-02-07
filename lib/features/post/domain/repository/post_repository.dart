import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';

abstract interface class IPostRepository {
  // Fetch all posts
  Future<Either<Failure, List<PostEntity>>> getPosts();

  // Create a new post
  Future<Either<Failure, void>> createPost(PostEntity post);

  // Delete a post by ID
  Future<Either<Failure, void>> deletePost(String id, String? token);

  // Update an existing post
  Future<Either<Failure, void>> updatePost(PostEntity post);
}


import '../../domain/entity/post_entity.dart';

abstract interface class IPostDataSource {
  // Fetch all posts
  Future<List<PostEntity>> getPosts();

  // Create a new post
  Future<void> createPost(PostEntity post);

  // Delete a post by ID
  Future<void> deletePost(String id, String? token);

  // Update an existing post
  Future<void> updatePost(PostEntity post);
}

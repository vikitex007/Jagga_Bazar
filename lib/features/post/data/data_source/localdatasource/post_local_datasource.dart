
import 'dart:io';

import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/post_entity.dart';
import '../../model/post_hive_model.dart';
import '../post_data_source.dart';

class PostLocalDataSource implements IPostDataSource {
  final HiveService hiveService;

  PostLocalDataSource({required this.hiveService});

  @override
  Future<void> createPost(PostEntity post) async {
    try {
      // Convert PostEntity to PostHiveModel
      final postHiveModel = PostHiveModel.fromEntity(post);
      await hiveService.addPost(postHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePost(String id, String? token) async {
    try {
      await hiveService.deletePost(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      return hiveService.getAllPosts().then(
            (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updatePost(PostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<String> uploadPicture(File file) {
    // TODO: implement uploadPicture
    throw UnimplementedError();
  }

  // Future<void> updatePost(PostEntity post) async {
  //   try {
  //     final postHiveModel = PostHiveModel.fromEntity(post);
  //     await hiveService.updatePost(postHiveModel);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}

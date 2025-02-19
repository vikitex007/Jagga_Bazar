import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/post_entity.dart';
import '../../model/post_api_model.dart';
import '../post_data_source.dart';

class PostRemoteDataSource implements IPostDataSource {
  final Dio _dio;

  PostRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createPost(PostEntity post) async {
    try {
      // Convert entity to model
      var postApiModel = PostApiModel.fromEntity(post);
      var response = await _dio.post(
        ApiEndpoints.createPost,
        data: postApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to create post: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  @override
  Future<void> deletePost(String postId, String? token) async {
    try {
      if (token == null) {
        throw Exception('Authorization token is required');
      }

      var response = await _dio.delete(
        ApiEndpoints.deletePost + postId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete post: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllPosts);
      if (response.statusCode == 200) {
        // Ensure the response is a map and has the 'data' key
        if (response.data is Map<String, dynamic> && response.data['data'] is List) {
          List<PostApiModel> postApiModels = (response.data['data'] as List)
              .map((item) => PostApiModel.fromJson(item))
              .toList();
          return postApiModels.map((model) => model.toEntity()).toList();
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to load posts: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  @override
  Future<void> updatePost(PostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<String> uploadPicture(File file) async {
    try {
      String fileName = file.path
          .split('/')
          .last;
      FormData formData = FormData.fromMap({
        'profilePicture':await MultipartFile.fromFile(file.path,filename: fileName),

      }
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage1,
        data: formData,
      );
      if(response.statusCode == 200){
        final str =response.data['data'];
        return str;
      }else{
        throw Exception(response.statusMessage);
      }
    }on DioException catch(e){
      throw Exception(e);
    }
    catch(e){
      throw Exception(e);

    }
  }
}

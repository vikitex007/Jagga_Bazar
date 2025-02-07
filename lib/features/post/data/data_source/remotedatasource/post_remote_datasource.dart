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
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePost(String postId, String? token) async {
    try {
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
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllPosts);
      if (response.statusCode == 200) {
        List<PostApiModel> postApiModels = (response.data as List)
            .map((item) => PostApiModel.fromJson(item))
            .toList();
        return postApiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updatePost(PostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jagga_bazar/app/constants/api_endpoints.dart';
import 'package:jagga_bazar/features/auth/data/data_source/auth_data_source.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String username, String password) async{
    try{
      final Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'username' :username,
          'password' :password
        }

      );
      if (response.statusCode == 200) {
        return "Login successful";
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }

    }on DioException catch (e) {
      throw Exception("HTTP error: ${e.response?.statusCode} - ${e.message}");
    }

    catch(e){
      throw Exception("Unexpected error: $e");

    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "fullName": user.fullName,
        "image": user.image,
        "phone": user.phone,
        "location": user.location,
        "username": user.username,
        "password": user.password,
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}

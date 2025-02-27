import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jagga_bazar/app/constants/api_endpoints.dart';
import 'package:jagga_bazar/features/auth/data/data_source/auth_data_source.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

import '../../model/auth_api_model.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
  //
  // Future<AuthEntity> updateProfile(String userId, String newUsername, String newPassword) async {
  //   try {
  //     Response response = await _dio.put(
  //       '${ApiEndpoints.updateUser}/$userId',
  //       data: {
  //         "username": newUsername,
  //         "password": newPassword,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Ensure response data is correctly converted
  //       final apiModel = AuthApiModel.fromJson(response.data as Map<String, dynamic>);
  //       return apiModel.toEntity(); // Convert to AuthEntity
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Future<String> loginUser(String username, String password) async {
    try{
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username":username,
          "password":password
        },
      );
      if(response.statusCode ==200){
        final str = response.data['token'];
        return str;
      }else{
        throw Exception(response.statusMessage);
      }
    }on DioException catch (e){
      throw Exception(e);
    }
    catch(e){
      throw Exception(e);

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
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path
          .split('/')
          .last;
      FormData formData = FormData.fromMap({
        'profilePicture':await MultipartFile.fromFile(file.path,filename: fileName),

      }
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
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



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jagga_bazar/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';
import 'package:jagga_bazar/features/auth/domain/repository/auth_repository.dart';

import '../../../../../core/error/failure.dart';

class AuthRemoteRepository implements IAuthRepository{
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository (this._authRemoteDataSource);


  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async{
    try{
      final currentUser = await _authRemoteDataSource.getCurrentUser();
      return Right(currentUser);
    }catch(e){
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(String username, String password) async {
   try{
     final token = await _authRemoteDataSource.loginUser(username, password);
         return Right(token);

   }

   catch(e){
     return Left(ApiFailure(message: e.toString()));
   }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async{
    try{
      return Right(_authRemoteDataSource.registerUser(user));
    }catch(e){
      return Left(ApiFailure(message: e.toString()));
    }


  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

}
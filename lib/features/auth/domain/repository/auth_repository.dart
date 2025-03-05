import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/common/internet_checker/internet_checker.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';


abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(
      String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
  //========================================================

  // Future<Either<Failure, AuthEntity>> getProfile();
  Future<Either<Failure, AuthEntity>> updateProfile(AuthEntity user);



// Future<Either<Failure, AuthEntity>> updateProfile(String userId, String newUsername, String newPassword);
}

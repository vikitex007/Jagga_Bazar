import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../core/common/internet_checker/internet_checker.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
   final String phone;
  final String location;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.fullName,
    required this.phone,
    required this.location,
    required this.username,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fullName,
    required this.phone,
    required this.location,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [fullName,  phone, location, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      phone: params.phone,
      location: params.location,
      username: params.username,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}

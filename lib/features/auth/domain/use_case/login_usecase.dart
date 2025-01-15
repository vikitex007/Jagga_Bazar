
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../core/common/internet_checker/internet_checker.dart';
import '../repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginUser(params.username, params.password);
  }
}

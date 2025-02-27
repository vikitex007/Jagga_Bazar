// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import '../../../../core/error/failure.dart';
// import '../entity/auth_entity.dart';
// import '../repository/auth_repository.dart';
// import '../../../../app/usecase/usecase.dart';
//
// class UpdateProfileParams extends Equatable {
//   final String userId;
//   final String username;
//   final String password;
//
//   const UpdateProfileParams({
//     required this.userId,
//     required this.username,
//     required this.password,
//   });
//
//   @override
//   List<Object?> get props => [userId, username, password];
// }
//
// class UpdateProfileUseCase implements UsecaseWithParams<AuthEntity, UpdateProfileParams> {
//   final IAuthRepository repository;
//   UpdateProfileUseCase(this.repository);
//
//   @override
//   Future<Either<Failure, AuthEntity>> call(UpdateProfileParams params) {
//     return repository.updateProfile(params.userId, params.username, params.password);
//   }
// }

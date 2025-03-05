import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class UpdateProfileUseCase {
  final IAuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(AuthEntity user) {
    return repository.updateProfile(user);
  }
}

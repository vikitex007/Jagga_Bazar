import '../../../domain/entity/auth_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final AuthEntity user;

  ProfileLoaded(this.user);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final AuthEntity user;

  ProfileUpdateSuccess(this.user);
}

class ProfileUpdateFailure extends ProfileState {
  final String message;

  ProfileUpdateFailure(this.message);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

import '../../../domain/entity/auth_entity.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final AuthEntity user;

  UpdateProfileEvent(this.user);
}

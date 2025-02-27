part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent{
  final File file;
  const LoadImage({
    required this.file,
});
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String location;
  final String phone;
  final String username;
  final String password;
  final String? image;

  const RegisterUser({
    required this.context,
    required this.fullName,
    required this.location,
    required this.phone,
    required this.username,
    required this.password,
    this.image,
  });
}
// class UpdateProfile extends RegisterEvent {
//   final String userId;
//   final String newUsername;
//   final String newPassword;
//   final BuildContext context;
//
//   const UpdateProfile({
//     required this.userId,
//     required this.newUsername,
//     required this.newPassword,
//     required this.context,
//   });
//
//   @override
//   List<Object> get props => [userId, newUsername, newPassword];
// }
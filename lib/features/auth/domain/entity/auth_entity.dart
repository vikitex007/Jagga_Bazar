import 'package:equatable/equatable.dart';
class AuthEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String? image;
  final String phone;
  final String location;
  final String username;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fullName,
    this.image,
    required this.phone,
    required this.location,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fullName,image, phone,location, username, password];
}

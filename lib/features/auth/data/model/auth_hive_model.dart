



import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/auth_entity.dart';



part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)

class AuthHiveModel extends Equatable{
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final String username;
  @HiveField(6)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.fullName,
    this.image,
    required this.phone,
    required this.location,
    required this.username,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();


  const AuthHiveModel.initial():
        userId='',
        fullName = '',
        image = '',
        phone = '',
        location = '',
        username = '',
        password = '';

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      image: entity.image,
      phone: entity.phone,
      location: entity.location,
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullName: fullName,
      image: image,
      phone: phone,
      location: location,
      username: username,
      password: password,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [userId,fullName,image,phone,location,username,password];

}
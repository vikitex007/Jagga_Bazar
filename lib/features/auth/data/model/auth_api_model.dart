

import 'package:equatable/equatable.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable{

  @JsonKey(name:'_id')
  final String? userId;
  final String fullName;
  final String? image;
  final String phone;
  final String location;
  final String username;
  final String password;

  const AuthApiModel({
    this.userId,
    required this.fullName,
    this.image,
    required this.phone,
    required this.location,
    required this.username,
    required this.password,
});

  factory AuthApiModel.fromJson (Map<String,dynamic> json) =>
      _$AuthApiModelFromJson(json);
  Map <String,dynamic> toJson()=> _$AuthApiModelToJson(this);




//to entity
  AuthEntity toEntity(){
    return AuthEntity(
        userId: userId,
        fullName:fullName,
        image: image,
        phone: phone,
        location:location,
        username: username,
        password: password
    );
  }
//From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity){
    return AuthApiModel(
        userId: entity.userId,
        fullName: entity.fullName,
        image: entity.image,
        phone: entity.phone,
        location: entity.location,
        username: entity.username,
        password: entity.password

    );
  }



  @override
  // TODO: implement props
  List<Object?> get props => [userId,fullName,image,phone,location,username,password];


}
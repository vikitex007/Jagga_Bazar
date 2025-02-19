// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      postId: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      image: json['image'] as String?,
      location: json['location'] as String,
      negotiable: json['negotiable'] as bool,
      postedBy: json['postedBy'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.postId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'location': instance.location,
      'image': instance.image,
      'negotiable': instance.negotiable,
      'postedBy': instance.postedBy,
      'createdAt': instance.createdAt,
    };

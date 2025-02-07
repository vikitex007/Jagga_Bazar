// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPostDTO _$GetAllPostDTOFromJson(Map<String, dynamic> json) =>
    GetAllPostDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPostDTOToJson(GetAllPostDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };

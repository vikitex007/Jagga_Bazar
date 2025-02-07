import 'package:json_annotation/json_annotation.dart';

import '../model/post_api_model.dart';

part 'get_all_post_dto.g.dart';

@JsonSerializable()
class GetAllPostDTO {
  final bool success;
  final int count;
  final List<PostApiModel> data;

  GetAllPostDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllPostDTOToJson(this);

  factory GetAllPostDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPostDTOFromJson(json);
}

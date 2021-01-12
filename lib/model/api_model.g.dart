// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiModel _$ApiModelFromJson(Map<String, dynamic> json) {
  return ApiModel(
    json['success'] as bool,
    json['message'] as String,
    json['data'],
  );
}

Map<String, dynamic> _$ApiModelToJson(ApiModel instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

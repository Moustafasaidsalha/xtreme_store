// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageModel _$ErrorMessageModelFromJson(Map<String, dynamic> json) =>
    ErrorMessageModel(
      json['status'] as int,
      json['message'] as String,
      json['flag'] as bool,
    );

Map<String, dynamic> _$ErrorMessageModelToJson(ErrorMessageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'flag': instance.flag,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      flag: json['flag'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'status': instance.status,
      'message': instance.message,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      email: json['email'] as String?,
      firstName: json['f_name'] as String?,
      lastName: json['l_name'] as String?,
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'f_name': instance.firstName,
      'l_name': instance.lastName,
    };

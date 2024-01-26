// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
      json['accessToken'] as String,
    );

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.user,
      'accessToken': instance.accessToken,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['email'] as String?,
      json['phone'] as String?,
      json['id'] as int?,
      json['f_name'] as String?,
      json['l_name'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'f_name': instance.firstName,
      'l_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
    };

EditProfileModel _$EditProfileModelFromJson(Map<String, dynamic> json) =>
    EditProfileModel(
      json['email'] as String?,
      json['f_name'] as String?,
      json['l_name'] as String?,
    );

Map<String, dynamic> _$EditProfileModelToJson(EditProfileModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'f_name': instance.firstName,
      'l_name': instance.lastName,
    };

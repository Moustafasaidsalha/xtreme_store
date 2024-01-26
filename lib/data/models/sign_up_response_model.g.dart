// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseModel _$SignUpResponseModelFromJson(Map<String, dynamic> json) =>
    SignUpResponseModel(
      flag: json['flag'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      userAccessData: json['user'] == null
          ? null
          : UserAccessData.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$SignUpResponseModelToJson(
        SignUpResponseModel instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'status': instance.status,
      'message': instance.message,
      'user': instance.userAccessData,
      'accessToken': instance.accessToken,
    };

UserAccessData _$UserAccessDataFromJson(Map<String, dynamic> json) =>
    UserAccessData(
      id: json['id'] as int?,
      firstName: json['f_name'] as String?,
      lastName: json['l_name'] as String?,
      email: json['email'] as String?,
      phones: (json['user_phones'] as List<dynamic>?)
          ?.map((e) => PhoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserAccessDataToJson(UserAccessData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'f_name': instance.firstName,
      'l_name': instance.lastName,
      'email': instance.email,
      'user_phones': instance.phones,
    };

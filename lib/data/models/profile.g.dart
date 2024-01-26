// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilesModel _$ProfilesModelFromJson(Map<String, dynamic> json) =>
    ProfilesModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : ProfileModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilesModelToJson(ProfilesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.userProfile,
    };

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      json['email'] as String?,
      (json['user_phones'] as List<dynamic>?)
          ?.map((e) => PhoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as int?,
      json['f_name'] as String?,
      json['l_name'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'f_name': instance.firstName,
      'l_name': instance.lastName,
      'email': instance.email,
      'user_phones': instance.phones,
    };

PhoneModel _$PhoneModelFromJson(Map<String, dynamic> json) => PhoneModel(
      json['id'] as int?,
      json['country_code'] as String?,
      json['phone'] as String?,
      json['is_default'] as bool?,
    );

Map<String, dynamic> _$PhoneModelToJson(PhoneModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_code': instance.countryCode,
      'phone': instance.phone,
      'is_default': instance.isDefault,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumberResponseModel _$PhoneNumberResponseModelFromJson(
        Map<String, dynamic> json) =>
    PhoneNumberResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      phoneNumbers: (json['data'] as List<dynamic>?)
          ?.map((e) => PhoneNumberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhoneNumberResponseModelToJson(
        PhoneNumberResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.phoneNumbers,
    };

PhoneNumberModel _$PhoneNumberModelFromJson(Map<String, dynamic> json) =>
    PhoneNumberModel(
      id: json['id'] as int?,
      countryCode: json['country_code'] as String?,
      phoneNumber: json['phone'] as String?,
    );

Map<String, dynamic> _$PhoneNumberModelToJson(PhoneNumberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_code': instance.countryCode,
      'phone': instance.phoneNumber,
    };

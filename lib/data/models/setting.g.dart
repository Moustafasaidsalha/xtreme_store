// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : SettingModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.settingModel,
    };

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
      json['snapchat'] as String?,
      json['facebook'] as String?,
      json['instagram'] as String?,
      json['whatsapp'] as String?,
      json['twitter'] as String?,
      json['tiktok'] as String?,
    );

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'snapchat': instance.snapchat,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'whatsapp': instance.whatsapp,
      'twitter': instance.twitter,
      'tiktok': instance.tiktok,
    };

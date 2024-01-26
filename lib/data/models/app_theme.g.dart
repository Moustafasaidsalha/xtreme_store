// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppThemeModel _$AppThemeModelFromJson(Map<String, dynamic> json) =>
    AppThemeModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : AppThemeDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppThemeModelToJson(AppThemeModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.appThemeDataModel,
    };

AppThemeDataModel _$AppThemeDataModelFromJson(Map<String, dynamic> json) =>
    AppThemeDataModel(
      json['mobile_logo'] as String?,
      json['main_color'] as String?,
      json['label_color'] as String?,
    );

Map<String, dynamic> _$AppThemeDataModelToJson(AppThemeDataModel instance) =>
    <String, dynamic>{
      'mobile_logo': instance.mobileLogo,
      'main_color': instance.mainColor,
      'label_color': instance.labelColor,
    };

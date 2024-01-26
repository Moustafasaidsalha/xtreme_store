// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_page_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticPageResponseModel _$StaticPageResponseModelFromJson(
        Map<String, dynamic> json) =>
    StaticPageResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StaticPageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StaticPageResponseModelToJson(
        StaticPageResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.data,
    };

StaticPageModel _$StaticPageModelFromJson(Map<String, dynamic> json) =>
    StaticPageModel(
      titleEN: json['title_en'] as String?,
      titleAR: json['title_ar'] as String?,
      descriptionEN: json['description_en'] as String?,
      descriptionAR: json['description_ar'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$StaticPageModelToJson(StaticPageModel instance) =>
    <String, dynamic>{
      'title_en': instance.titleEN,
      'title_ar': instance.titleAR,
      'description_en': instance.descriptionEN,
      'description_ar': instance.descriptionAR,
      'type': instance.type,
    };

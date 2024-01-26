// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdScreensModel _$AdScreensModelFromJson(Map<String, dynamic> json) =>
    AdScreensModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : AdScreenMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdScreensModelToJson(AdScreensModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.adScreenMetaModel,
    };

AdScreenMetaModel _$AdScreenMetaModelFromJson(Map<String, dynamic> json) =>
    AdScreenMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => AdScreenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$AdScreenMetaModelToJson(AdScreenMetaModel instance) =>
    <String, dynamic>{
      'data': instance.adScreens,
      'totalLength': instance.totalLength,
    };

AdScreenModel _$AdScreenModelFromJson(Map<String, dynamic> json) =>
    AdScreenModel(
      json['image'] as String?,
      json['product_id'] as int?,
      json['category_id'] as int?,
    );

Map<String, dynamic> _$AdScreenModelToJson(AdScreenModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'product_id': instance.productId,
      'category_id': instance.categoryId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsModel _$BrandsModelFromJson(Map<String, dynamic> json) => BrandsModel(
      (json['status'] as num?)?.toDouble(),
      json['flag'] as bool?,
      json['message'] as String?,
      json['meta'] == null
          ? null
          : BrandsMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BrandsModelToJson(BrandsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'flag': instance.flag,
      'message': instance.message,
      'meta': instance.brandsMetaModel,
    };

BrandsMetaModel _$BrandsMetaModelFromJson(Map<String, dynamic> json) =>
    BrandsMetaModel(
      json['totalLength'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => BrandDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandsMetaModelToJson(BrandsMetaModel instance) =>
    <String, dynamic>{
      'totalLength': instance.totalLength,
      'data': instance.brands,
    };

BrandDataModel _$BrandDataModelFromJson(Map<String, dynamic> json) =>
    BrandDataModel(
      json['id'] as int?,
      json['name_en'] as String?,
      json['name_ar'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$BrandDataModelToJson(BrandDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'image': instance.image,
    };

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => BrandModel(
      json['name_en'] as String?,
      json['name_ar'] as String?,
    );

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };

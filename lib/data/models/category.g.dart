// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : CategoryMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.categoryMetaModel,
    };

CategoryMetaModel _$CategoryMetaModelFromJson(Map<String, dynamic> json) =>
    CategoryMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$CategoryMetaModelToJson(CategoryMetaModel instance) =>
    <String, dynamic>{
      'data': instance.categories,
      'totalLength': instance.totalLength,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['id'] as int?,
      json['name_ar'] as String?,
      json['name_en'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEN,
      'image': instance.image,
    };

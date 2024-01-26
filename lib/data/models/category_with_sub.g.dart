// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_with_sub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesWithSubsModel _$CategoriesWithSubsModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesWithSubsModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : CategoriesWithSubsMetaModel.fromJson(
              json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesWithSubsModelToJson(
        CategoriesWithSubsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.categoriesWithSubsMetaModel,
    };

CategoriesWithSubsMetaModel _$CategoriesWithSubsMetaModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesWithSubsMetaModel(
      json['totalLength'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CategoriesWithSubsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesWithSubsMetaModelToJson(
        CategoriesWithSubsMetaModel instance) =>
    <String, dynamic>{
      'totalLength': instance.totalLength,
      'data': instance.categoriesWithSubsDataModel,
    };

CategoriesWithSubsDataModel _$CategoriesWithSubsDataModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesWithSubsDataModel(
      json['id'] as int?,
      json['name_ar'] as String?,
      json['name_en'] as String?,
      json['image'] as String?,
      (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => SubModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesWithSubsDataModelToJson(
        CategoriesWithSubsDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEN,
      'image': instance.image,
      'sub_categories': instance.subs,
    };

SubModel _$SubModelFromJson(Map<String, dynamic> json) => SubModel(
      json['id'] as int?,
      json['name_ar'] as String?,
      json['name_en'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$SubModelToJson(SubModel instance) => <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEN,
      'image': instance.image,
    };

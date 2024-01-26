// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoriesModel _$SubCategoriesModelFromJson(Map<String, dynamic> json) =>
    SubCategoriesModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : SubCategoryMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoriesModelToJson(SubCategoriesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.subCategoryMetaModel,
    };

SubCategoryMetaModel _$SubCategoryMetaModelFromJson(
        Map<String, dynamic> json) =>
    SubCategoryMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$SubCategoryMetaModelToJson(
        SubCategoryMetaModel instance) =>
    <String, dynamic>{
      'data': instance.subCategories,
      'totalLength': instance.totalLength,
    };

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      json['id'] as int?,
      json['name_ar'] as String?,
      json['name_en'] as String?,
      json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      json['image'] as String?,
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEN,
      'image': instance.image,
      'category': instance.category,
    };

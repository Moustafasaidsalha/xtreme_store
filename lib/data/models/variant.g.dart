// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) => VariantModel(
      json['status'] as int?,
      json['flag'] as bool?,
      json['message'] as String?,
      json['meta'] == null
          ? null
          : VariantMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'flag': instance.flag,
      'message': instance.message,
      'meta': instance.variantMetaModel,
    };

VariantMetaModel _$VariantMetaModelFromJson(Map<String, dynamic> json) =>
    VariantMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => VariantDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$VariantMetaModelToJson(VariantMetaModel instance) =>
    <String, dynamic>{
      'data': instance.variants,
      'totalLength': instance.totalLength,
    };

VariantDetailsModel _$VariantDetailsModelFromJson(Map<String, dynamic> json) =>
    VariantDetailsModel(
      json['id'] as int?,
      json['name_en'] as String?,
      json['name_ar'] as String?,
      (json['variant_values'] as List<dynamic>?)
          ?.map((e) => VariantValuesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantDetailsModelToJson(
        VariantDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'variant_values': instance.variantValues,
    };

VariantValuesModel _$VariantValuesModelFromJson(Map<String, dynamic> json) =>
    VariantValuesModel(
      json['id'] as int?,
      json['value_en'] as String?,
      json['value_ar'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$VariantValuesModelToJson(VariantValuesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value_en': instance.valueEn,
      'value_ar': instance.valueAr,
      'isSelected': instance.isSelected,
    };

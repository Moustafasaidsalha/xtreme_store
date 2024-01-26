// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_variants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicVariantsModel _$DynamicVariantsModelFromJson(
        Map<String, dynamic> json) =>
    DynamicVariantsModel(
      json['status'] as int?,
      json['flag'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => DynamicVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DynamicVariantsModelToJson(
        DynamicVariantsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'flag': instance.flag,
      'message': instance.message,
      'data': instance.dynamicVariantModel,
    };

DynamicVariantModel _$DynamicVariantModelFromJson(Map<String, dynamic> json) =>
    DynamicVariantModel(
      json['id'] as int?,
      json['name_en'] as String?,
      json['name_ar'] as String?,
      json['available_amount'] as int?,
      json['has_amount'] as bool?,
      DynamicVariantModel.doubleFromString(json['price'] as String?),
    );

Map<String, dynamic> _$DynamicVariantModelToJson(
        DynamicVariantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'available_amount': instance.availableAmount,
      'has_amount': instance.hasAmount,
      'price': instance.price,
    };

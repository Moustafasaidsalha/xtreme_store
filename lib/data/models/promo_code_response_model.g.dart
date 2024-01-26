// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeResponseModel _$PromoCodeResponseModelFromJson(
        Map<String, dynamic> json) =>
    PromoCodeResponseModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : PromoCodeDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromoCodeResponseModelToJson(
        PromoCodeResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.promoCodeDataModel,
    };

PromoCodesMetaModel _$PromoCodesMetaModelFromJson(Map<String, dynamic> json) =>
    PromoCodesMetaModel(
      json['totalLength'] as int?,
      json['data'] == null
          ? null
          : PromoCodeModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromoCodesMetaModelToJson(
        PromoCodesMetaModel instance) =>
    <String, dynamic>{
      'totalLength': instance.totalLength,
      'data': instance.promoCodeModel,
    };

PromoCodeModel _$PromoCodeModelFromJson(Map<String, dynamic> json) =>
    PromoCodeModel(
      json['id'] as String?,
      json['name'] as String?,
      json['amount'] as String?,
      json['Type'] as String?,
      json['end_date'] as String?,
      json['max_usage'] as int?,
      json['count_usage'] as int?,
    );

Map<String, dynamic> _$PromoCodeModelToJson(PromoCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'Type': instance.type,
      'end_date': instance.endDate,
      'max_usage': instance.maxUsage,
      'count_usage': instance.countUsage,
    };

PromoCodeDataModel _$PromoCodeDataModelFromJson(Map<String, dynamic> json) =>
    PromoCodeDataModel(
      couponType: json['coupon_type'] as String?,
      couponValue: (json['coupon_value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromoCodeDataModelToJson(PromoCodeDataModel instance) =>
    <String, dynamic>{
      'coupon_type': instance.couponType,
      'coupon_value': instance.couponValue,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCartResponseModel _$LocalCartResponseModelFromJson(
        Map<String, dynamic> json) =>
    LocalCartResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      data: json['data'] == null
          ? null
          : LocalCartModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalCartResponseModelToJson(
        LocalCartResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.data,
    };

LocalCartModel _$LocalCartModelFromJson(Map<String, dynamic> json) =>
    LocalCartModel(
      currency: json['currencyType'] as String?,
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      subCarts: (json['products'] as List<dynamic>?)
          ?.map((e) => SubCarts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalCartModelToJson(LocalCartModel instance) =>
    <String, dynamic>{
      'currencyType': instance.currency,
      'sub_total': instance.subTotal,
      'products': instance.subCarts,
    };

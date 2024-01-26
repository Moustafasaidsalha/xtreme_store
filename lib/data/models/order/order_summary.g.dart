// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummaryModel _$OrderSummaryModelFromJson(Map<String, dynamic> json) =>
    OrderSummaryModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] == null
          ? null
          : OrderSummaryDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderSummaryModelToJson(OrderSummaryModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.orderSummaryDataModel,
    };

OrderSummaryDataModel _$OrderSummaryDataModelFromJson(
        Map<String, dynamic> json) =>
    OrderSummaryDataModel(
      shippingFee: (json['shipping_fee'] as num?)?.toDouble(),
      cashInDelivery: (json['cash_in_delivery'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderSummaryDataModelToJson(
        OrderSummaryDataModel instance) =>
    <String, dynamic>{
      'shipping_fee': instance.shippingFee,
      'cash_in_delivery': instance.cashInDelivery,
      'total': instance.total,
      'sub_total': instance.subTotal,
      'discount_amount': instance.discountAmount,
    };

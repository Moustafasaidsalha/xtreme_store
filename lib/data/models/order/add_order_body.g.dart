// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrderBody _$AddOrderBodyFromJson(Map<String, dynamic> json) => AddOrderBody(
      day: json['day'] as String?,
      paymentMethod: json['payment_method'] as String?,
      userAddressID: json['user_address_id'] as int?,
      cartID: json['cart_id'] as int?,
      intervalHourID: json['interval_hours_id'] as int?,
    );

Map<String, dynamic> _$AddOrderBodyToJson(AddOrderBody instance) =>
    <String, dynamic>{
      'day': instance.day,
      'payment_method': instance.paymentMethod,
      'user_address_id': instance.userAddressID,
      'cart_id': instance.cartID,
      'interval_hours_id': instance.intervalHourID,
    };

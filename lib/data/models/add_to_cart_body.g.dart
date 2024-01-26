// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartBody _$AddToCartBodyFromJson(Map<String, dynamic> json) =>
    AddToCartBody(
      promoCode: json['promoCode'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddToCartBodyToJson(AddToCartBody instance) =>
    <String, dynamic>{
      'promoCode': instance.promoCode,
      'products': instance.products,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      dynamicVariant: (json['dynamic_variant'] as List<dynamic>?)
          ?.map((e) => DynamicVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: json['amount'] as int?,
      productId: json['product_id'] as int?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'dynamic_variant': instance.dynamicVariant,
      'amount': instance.amount,
      'product_id': instance.productId,
    };

DynamicVariant _$DynamicVariantFromJson(Map<String, dynamic> json) =>
    DynamicVariant(
      amount: json['amount'] as int?,
      dynamicVariantId: json['dynamic_variant_id'] as int?,
    );

Map<String, dynamic> _$DynamicVariantToJson(DynamicVariant instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'dynamic_variant_id': instance.dynamicVariantId,
    };

AddToCartLocalBody _$AddToCartLocalBodyFromJson(Map<String, dynamic> json) =>
    AddToCartLocalBody(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddToCartLocalBodyToJson(AddToCartLocalBody instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

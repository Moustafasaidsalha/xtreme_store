// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseModel _$CartResponseModelFromJson(Map<String, dynamic> json) =>
    CartResponseModel(
      data: json['data'] == null
          ? null
          : CartModel.fromJson(json['data'] as Map<String, dynamic>),
      flag: json['flag'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CartResponseModelToJson(CartResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'flag': instance.flag,
      'status': instance.status,
      'message': instance.message,
    };

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      total: (json['total'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      couponName: json['coupon_name'] as String?,
      couponValue: json['coupon_value'] as int?,
      promoCodeId: json['promoCode_id'] as int?,
      couponType: json['coupon_type'] as String?,
      subCarts: (json['sub_carts'] as List<dynamic>?)
          ?.map((e) => SubCarts.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencyType: json['currencyType'] as String?,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      localProducts: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingFee: (json['shipping_fee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'total': instance.total,
      'sub_total': instance.subTotal,
      'coupon_name': instance.couponName,
      'coupon_value': instance.couponValue,
      'promoCode_id': instance.promoCodeId,
      'coupon_type': instance.couponType,
      'discount_amount': instance.discountAmount,
      'currencyType': instance.currencyType,
      'shipping_fee': instance.shippingFee,
      'sub_carts': instance.subCarts,
      'products': instance.localProducts,
    };

SubCarts _$SubCartsFromJson(Map<String, dynamic> json) => SubCarts(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      productId: json['product_id'] as int?,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      dynamicVariantCarts: (json['dynamic_variant_carts'] as List<dynamic>?)
          ?.map((e) => DynamicVariantCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubCartsToJson(SubCarts instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'product_id': instance.productId,
      'product': instance.product,
      'dynamic_variant_carts': instance.dynamicVariantCarts,
    };

DynamicVariantCart _$DynamicVariantCartFromJson(Map<String, dynamic> json) =>
    DynamicVariantCart(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      subCartID: json['sub_cart_id'] as int?,
      dynamicVariantID: json['dynamic_variant_id'] as int?,
      dynamicVariant: json['dynamic_variant'] == null
          ? null
          : DynamicVariant.fromJson(
              json['dynamic_variant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DynamicVariantCartToJson(DynamicVariantCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'sub_cart_id': instance.subCartID,
      'dynamic_variant_id': instance.dynamicVariantID,
      'dynamic_variant': instance.dynamicVariant,
    };

DynamicVariant _$DynamicVariantFromJson(Map<String, dynamic> json) =>
    DynamicVariant(
      id: json['id'] as int?,
      nameEN: json['name_en'] as String?,
      nameAR: json['name_ar'] as String?,
      price: DynamicVariant.doubleFromString(json['price'] as String),
    );

Map<String, dynamic> _$DynamicVariantToJson(DynamicVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEN,
      'name_ar': instance.nameAR,
      'price': instance.price,
    };

import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/product.dart';

part 'cart_response_model.g.dart';

@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: "data")
  final CartModel? data;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;

  CartResponseModel({this.data, this.flag, this.status, this.message});
  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);
}

@JsonSerializable()
class CartModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "total")
  final double? total;
  @JsonKey(name: "sub_total")
  final double? subTotal;
  @JsonKey(name: "coupon_name")
  final String? couponName;
  @JsonKey(name: "coupon_value")
  final int? couponValue;
  @JsonKey(name: "promoCode_id")
  final int? promoCodeId;
  @JsonKey(name: "coupon_type")
  final String? couponType;
  @JsonKey(name: "discount_amount")
  final double? discountAmount;
  @JsonKey(name: "currencyType")
  final String? currencyType;
  @JsonKey(name: "shipping_fee")
  final double? shippingFee;
  @JsonKey(name: "sub_carts")
  final List<SubCarts>? subCarts;
  @JsonKey(name: "products")
  final List<ProductModel>? localProducts;

  CartModel({
    this.id,
    this.userId,
    this.total,
    this.subTotal,
    this.couponName,
    this.couponValue,
    this.promoCodeId,
    this.couponType,
    this.subCarts,
    this.currencyType,
    this.discountAmount,
    this.localProducts,
    this.shippingFee,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class SubCarts {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "product")
  final ProductModel? product;
  @JsonKey(name: "dynamic_variant_carts")
  final List<DynamicVariantCart>? dynamicVariantCarts;

  SubCarts({
    this.id,
    this.amount,
    this.productId,
    this.product,
    this.dynamicVariantCarts,
  });
  factory SubCarts.fromJson(Map<String, dynamic> json) => _$SubCartsFromJson(json);

  Map<String, dynamic> toJson() => _$SubCartsToJson(this);
}

@JsonSerializable()
class DynamicVariantCart {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "sub_cart_id")
  final int? subCartID;
  @JsonKey(name: "dynamic_variant_id")
  final int? dynamicVariantID;
  @JsonKey(name: "dynamic_variant")
  final DynamicVariant? dynamicVariant;

  DynamicVariantCart({
    this.id,
    this.amount,
    this.subCartID,
    this.dynamicVariantID,
    this.dynamicVariant,
  });
  factory DynamicVariantCart.fromJson(Map<String, dynamic> json) => _$DynamicVariantCartFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantCartToJson(this);
}

@JsonSerializable()
class DynamicVariant {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEN;
  @JsonKey(name: "name_ar")
  final String? nameAR;
  @JsonKey(name: "price",fromJson:doubleFromString )
  final double? price;
  static double doubleFromString(String value) {
    return double.parse(value);}
  DynamicVariant({this.id, this.nameEN, this.nameAR, this.price});
  factory DynamicVariant.fromJson(Map<String, dynamic> json) => _$DynamicVariantFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantToJson(this);
}

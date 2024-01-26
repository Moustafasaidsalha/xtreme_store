import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_body.g.dart';

@JsonSerializable()
class AddToCartBody {
  @JsonKey(name: "promoCode")
  final String? promoCode;
  @JsonKey(name: "products")
  final List<Products>? products;

  AddToCartBody({this.promoCode, this.products});

  factory AddToCartBody.fromJson(Map<String, dynamic> json) => _$AddToCartBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartBodyToJson(this);
}

@JsonSerializable()
class Products {
  @JsonKey(name: "dynamic_variant")
  final List<DynamicVariant>? dynamicVariant;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "product_id")
  final int? productId;

  Products({this.dynamicVariant, this.amount, this.productId});

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable()
class DynamicVariant {
  @JsonKey(name: "amount")
  int? amount;
  @JsonKey(name: "dynamic_variant_id")
  int? dynamicVariantId;

  DynamicVariant({this.amount, this.dynamicVariantId});

  factory DynamicVariant.fromJson(Map<String, dynamic> json) => _$DynamicVariantFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantToJson(this);
}


@JsonSerializable()
class AddToCartLocalBody {

  @JsonKey(name: "products")
  final List<Products>? products;

  AddToCartLocalBody({this.products});

  factory AddToCartLocalBody.fromJson(Map<String, dynamic> json) => _$AddToCartLocalBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartLocalBodyToJson(this);
}
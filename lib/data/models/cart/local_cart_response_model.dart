import 'package:json_annotation/json_annotation.dart';

import '../cart_response_model.dart';

part 'local_cart_response_model.g.dart';

@JsonSerializable()
class LocalCartResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final LocalCartModel? data;

  const LocalCartResponseModel({
    this.message,
    this.status,
    this.flag,
    this.data,
  });

  factory LocalCartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocalCartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalCartResponseModelToJson(this);
}

@JsonSerializable()
class LocalCartModel {
  @JsonKey(name: "currencyType")
  final String? currency;
  @JsonKey(name: "sub_total")
  final double? subTotal;
  @JsonKey(name: "products")
  final List<SubCarts>? subCarts;

  LocalCartModel({this.currency, this.subTotal, this.subCarts});

  factory LocalCartModel.fromJson(Map<String, dynamic> json) => _$LocalCartModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalCartModelToJson(this);
}

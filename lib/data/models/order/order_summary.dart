import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_summary.g.dart';

@JsonSerializable()
class OrderSummaryModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final OrderSummaryDataModel? orderSummaryDataModel;

  const OrderSummaryModel(this.message, this.status, this.flag, this.orderSummaryDataModel);

  @override
  List<Object?> get props => [message, status, flag];

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) => _$OrderSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSummaryModelToJson(this);
}

@JsonSerializable()
class OrderSummaryDataModel extends Equatable {
  @JsonKey(name: "shipping_fee")
  final double? shippingFee;
  @JsonKey(name: "cash_in_delivery")
  final double? cashInDelivery;
  @JsonKey(name: "total")
  final double? total;
  @JsonKey(name: "sub_total")
  final double? subTotal;
  @JsonKey(name: "discount_amount")
  final double? discountAmount;

  const OrderSummaryDataModel({
    this.shippingFee,
    this.cashInDelivery,
    this.total,
    this.subTotal,
    this.discountAmount,
  });

  @override
  List<Object?> get props => [shippingFee, cashInDelivery, total, subTotal];

  factory OrderSummaryDataModel.fromJson(Map<String, dynamic> json) => _$OrderSummaryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSummaryDataModelToJson(this);
}

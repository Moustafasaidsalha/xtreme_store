import 'package:json_annotation/json_annotation.dart';

part 'add_order_body.g.dart';

@JsonSerializable()
class AddOrderBody {
  @JsonKey(name: "day")
  final String? day;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  @JsonKey(name: "user_address_id")
  final int? userAddressID;
  @JsonKey(name: "cart_id")
  final int? cartID;
  @JsonKey(name: "interval_hours_id")
  final int? intervalHourID;

  const AddOrderBody({
    this.day,
    this.paymentMethod,
    this.userAddressID,
    this.cartID,
    this.intervalHourID,
  });

  factory AddOrderBody.fromJson(Map<String, dynamic> json) => _$AddOrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderBodyToJson(this);
}

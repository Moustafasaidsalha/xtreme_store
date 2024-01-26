import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  final String? data;

  const OrderResponseModel(this.message, this.status, this.flag,this.data);

  @override
  List<Object?> get props => [message, status, flag];

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => _$OrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);
}

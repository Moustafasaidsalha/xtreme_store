import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promo_code_response_model.g.dart';

@JsonSerializable()
class PromoCodeResponseModel extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final PromoCodeDataModel? promoCodeDataModel;

  const PromoCodeResponseModel(this.message, this.status, this.flag, this.promoCodeDataModel);

  @override
  List<Object?> get props => [
        message,
        status,
        flag,
    promoCodeDataModel,
      ];

  factory PromoCodeResponseModel.fromJson(Map<String, dynamic> json) => _$PromoCodeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeResponseModelToJson(this);
}

@JsonSerializable()
class PromoCodesMetaModel extends Equatable {
  final int? totalLength;
  @JsonKey(name: "data")
  final PromoCodeModel? promoCodeModel;

  const PromoCodesMetaModel(this.totalLength, this.promoCodeModel);

  @override
  List<Object?> get props => [totalLength];

  factory PromoCodesMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PromoCodesMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodesMetaModelToJson(this);
}

@JsonSerializable()
class PromoCodeModel extends Equatable {
  final String? id;

  final String? name;

  final String? amount;

  @JsonKey(name: "Type")
  final String? type;
  @JsonKey(name: "end_date")
  final String? endDate;
  @JsonKey(name: "max_usage")
  final int? maxUsage;
  @JsonKey(name: "count_usage")
  final int? countUsage;

  const PromoCodeModel(
      this.id, this.name, this.amount, this.type, this.endDate, this.maxUsage, this.countUsage);

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        type,
        endDate,
        maxUsage,
        countUsage,
      ];
  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => _$PromoCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeModelToJson(this);
}

@JsonSerializable()
class PromoCodeDataModel {
  @JsonKey(name: "coupon_type")
  final String? couponType;
  @JsonKey(name: "coupon_value")
  final double? couponValue;

  PromoCodeDataModel({this.couponType, this.couponValue});

  factory PromoCodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeDataModelToJson(this);
}

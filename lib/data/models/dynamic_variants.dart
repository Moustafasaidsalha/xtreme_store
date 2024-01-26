import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dynamic_variants.g.dart';

@JsonSerializable()
class DynamicVariantsModel extends Equatable {
  final int? status;
  final bool? flag;
  final String? message;

  @JsonKey(name: "data")
  final List<DynamicVariantModel>? dynamicVariantModel;

  const DynamicVariantsModel(this.status, this.flag, this.message,
      this.dynamicVariantModel);

  @override
  List<Object?> get props => [status, flag, message, dynamicVariantModel];

  factory DynamicVariantsModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicVariantsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantsModelToJson(this);
}



@JsonSerializable()
class DynamicVariantModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "available_amount")
  final int? availableAmount;
  @JsonKey(name: "has_amount")
  final bool? hasAmount;
  @JsonKey(fromJson: doubleFromString)

  final double? price;

  static double doubleFromString(String? value) {
    if(value==null||value.isEmpty){
      return 0;

    }else{
      return double.parse(value);

    }
  }
  const DynamicVariantModel(this.id, this.nameEn, this.nameAr,
      this.availableAmount,
      this.hasAmount, this.price);

  @override
  List<Object?> get props =>
      [id, nameEn, nameAr, availableAmount, hasAmount, price,];


  factory DynamicVariantModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicVariantModelToJson(this);
}
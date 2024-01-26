import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variant.g.dart';

@JsonSerializable()
class VariantModel extends Equatable {
  // @JsonKey(name: "variant_value_id")
  // final double? variantValueId;
  //
  //
  // @JsonKey(name: "variant_id")
  // final double? variantId;
  // const Variant(this.variantValueId, this.variantId);
  //
  // @override
  // List<Object?> get props => [variantId,variantValueId];
  final int? status;
  final bool? flag;
  final String? message;
  @JsonKey(name: "meta")
  final VariantMetaModel? variantMetaModel;


  const VariantModel(this.status, this.flag, this.message, this.variantMetaModel);

  @override
  List<Object?> get props => [status, flag, message, variantMetaModel];

  factory VariantModel.fromJson(Map<String, dynamic> json) =>
      _$VariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantModelToJson(this);


}

@JsonSerializable()
class VariantMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<VariantDetailsModel>? variants;
  final int totalLength;

  const VariantMetaModel(this.variants, this.totalLength);

  @override
  List<Object?> get props => [variants, totalLength];
  factory VariantMetaModel.fromJson(Map<String, dynamic> json) =>
      _$VariantMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantMetaModelToJson(this);
}

@JsonSerializable()
class VariantDetailsModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "variant_values")
  final List<VariantValuesModel>? variantValues;

  const VariantDetailsModel(this.id, this.nameEn, this.nameAr,
      this.variantValues);

  @override
  List<Object?> get props => [id, nameEn, nameAr, variantValues];

  factory VariantDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$VariantDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantDetailsModelToJson(this);


}

@JsonSerializable()
class VariantValuesModel extends Equatable {
  final int? id;
  @JsonKey(name: "value_en")
  final String? valueEn;
  @JsonKey(name: "value_ar")
  final String? valueAr;
  final bool? isSelected;

  const VariantValuesModel(this.id, this.valueEn, this.valueAr,this.isSelected);

  @override
  List<Object?> get props => [id, valueEn, valueAr,isSelected];

  factory VariantValuesModel.fromJson(Map<String, dynamic> json) =>
      _$VariantValuesModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantValuesModelToJson(this);


}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable()
class BrandsModel extends Equatable {
  final double? status;
  final bool? flag;
  final String? message;

  @JsonKey(name: "meta")
  final BrandsMetaModel? brandsMetaModel;

  const BrandsModel(this.status, this.flag, this.message, this.brandsMetaModel);

  @override
  List<Object?> get props => [status, flag, message, brandsMetaModel];
  factory BrandsModel.fromJson(Map<String, dynamic> json) =>
      _$BrandsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandsModelToJson(this);
}

@JsonSerializable()
class BrandsMetaModel extends Equatable {
  final int? totalLength;

  @JsonKey(name: "data")
  final List<BrandDataModel>? brands;

  const BrandsMetaModel(this.totalLength, this.brands);

  @override
  List<Object?> get props => [totalLength, brands];
  factory BrandsMetaModel.fromJson(Map<String, dynamic> json) =>
      _$BrandsMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandsMetaModelToJson(this);
}

@JsonSerializable()
class BrandDataModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  final String? image;

  const BrandDataModel(this.id, this.nameEn, this.nameAr, this.image);

  @override
  List<Object?> get props => [id, nameEn, nameAr, image];
  factory BrandDataModel.fromJson(Map<String, dynamic> json) =>
      _$BrandDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDataModelToJson(this);

}

@JsonSerializable()
class BrandModel extends Equatable {
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;

  const BrandModel(this.nameEn, this.nameAr);

  @override
  List<Object?> get props => [nameEn, nameAr];

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
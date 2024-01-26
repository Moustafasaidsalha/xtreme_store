import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_with_sub.g.dart';

@JsonSerializable()
class CategoriesWithSubsModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")
  final CategoriesWithSubsMetaModel? categoriesWithSubsMetaModel;

 const CategoriesWithSubsModel(this.message, this.status, this.flag,
      this.categoriesWithSubsMetaModel);

  @override
  List<Object?> get props =>
      [message, status, flag, categoriesWithSubsMetaModel,];
  factory CategoriesWithSubsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesWithSubsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesWithSubsModelToJson(this);
}

@JsonSerializable()
class CategoriesWithSubsMetaModel extends Equatable {
  final int? totalLength;
  @JsonKey(name: "data")
  final List<CategoriesWithSubsDataModel>? categoriesWithSubsDataModel;

  const CategoriesWithSubsMetaModel(this.totalLength,
      this.categoriesWithSubsDataModel);

  @override
  List<Object?> get props => [totalLength, categoriesWithSubsDataModel];

  factory CategoriesWithSubsMetaModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesWithSubsMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesWithSubsMetaModelToJson(this);
}

@JsonSerializable()
class CategoriesWithSubsDataModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEN;
  final String? image;

  @JsonKey(name: "sub_categories")
  final List<SubModel>? subs;

  const CategoriesWithSubsDataModel(this.id, this.nameAr, this.nameEN,
      this.image,
      this.subs);

  @override
  List<Object?> get props => [id, nameAr, nameEN, image, subs];

  factory CategoriesWithSubsDataModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesWithSubsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesWithSubsDataModelToJson(this);
}

@JsonSerializable()
class SubModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEN;
  final String? image;

  const SubModel(this.id, this.nameAr, this.nameEN,
      this.image);

  @override
  List<Object?> get props => [id, nameAr, nameEN, image];

  factory SubModel.fromJson(Map<String, dynamic> json)=>
      _$SubModelFromJson(json);


  Map<String, dynamic> toJson() => _$SubModelToJson(this);


}
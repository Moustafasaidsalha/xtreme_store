import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/category.dart';

part 'sub_category.g.dart';

@JsonSerializable()
class SubCategoriesModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")
  final SubCategoryMetaModel? subCategoryMetaModel;


  const SubCategoriesModel(this.message, this.status, this.flag,
      this.subCategoryMetaModel);

  @override
  List<Object?> get props => [message, status, flag, subCategoryMetaModel];

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoriesModelToJson(this);

}

@JsonSerializable()
class SubCategoryMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<SubCategoryModel>? subCategories;
  final int totalLength;

 const  SubCategoryMetaModel(this.subCategories, this.totalLength);

  @override
  List<Object?> get props => [subCategories, totalLength];
  factory SubCategoryMetaModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryMetaModelToJson(this);
}

@JsonSerializable()
class SubCategoryModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEN;
  final String? image;
  final CategoryModel? category;

  const SubCategoryModel(this.id, this.nameAr, this.nameEN, this.category,
      this.image);

  @override
  List<Object?> get props => [id, nameAr, nameEN, category, image];

  factory SubCategoryModel.fromJson(Map<String, dynamic> json)=>
      _$SubCategoryModelFromJson(json);


  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);


}
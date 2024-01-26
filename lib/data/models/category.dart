import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoriesModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")

  final CategoryMetaModel? categoryMetaModel;


  const CategoriesModel(this.message, this.status, this.flag, this.categoryMetaModel);

  @override
  List<Object?> get props => [message, status, flag, categoryMetaModel];

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);


}

@JsonSerializable()
class CategoryMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<CategoryModel>? categories;
  final int totalLength;

  const CategoryMetaModel(this.categories, this.totalLength);

  @override
  List<Object?> get props => [categories, totalLength];
  factory CategoryMetaModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryMetaModelToJson(this);
}

@JsonSerializable()
class CategoryModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(name: "name_en")
  final String? nameEN;
  final String? image;

  const CategoryModel(this.id, this.nameAr, this.nameEN, this.image);

  @override
  List<Object?> get props => [id, nameAr, nameEN, image];

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

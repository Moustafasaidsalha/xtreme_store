import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/brand.dart';
import 'package:extreme_store/data/models/variant.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductsModel extends Equatable {
  final int? status;
  final bool? flag;
  final String? message;
  @JsonKey(name: "meta")
  final ProductMetaModel? productMetaModel;

  const ProductsModel(this.status, this.flag, this.message, this.productMetaModel);

  @override
  List<Object?> get props => [status, flag, message, productMetaModel];

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}

@JsonSerializable()
class ProductMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<ProductModel>? products;
  final int totalLength;

  const ProductMetaModel(this.products, this.totalLength);

  @override
  List<Object?> get props => [products, totalLength];

  factory ProductMetaModel.fromJson(Map<String, dynamic> json) => _$ProductMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetaModelToJson(this);
}

@JsonSerializable()
class ProductDetailsModel extends Equatable {
  final int? status;
  final bool? flag;
  final String? message;
  @JsonKey(name: "data")
  final ProductDataModel? productModel;

  const ProductDetailsModel(this.status, this.flag, this.message, this.productModel);

  @override
  List<Object?> get props => [status, flag, message, productModel];

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable()
class ProductDataModel extends Equatable {
  @JsonKey(name: "product")
  final ProductModel? productModel;
  final List<VariantDetailsModel>? variant;

  const ProductDataModel(this.productModel, this.variant);

  @override
  List<Object?> get props => [productModel, variant];
  factory ProductDataModel.fromJson(Map<String, dynamic> json) => _$ProductDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataModelToJson(this);
}

@JsonSerializable()
class ProductModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(fromJson: doubleFromString)
  final double? price;
  final String? code;
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "brand_id")
  final int? brandId;
  final BrandModel? brand;
  final CategoryForProduct? categoryForProduct;

  final List<ImageModel>? images;

  @JsonKey(name: "sub_category_id")
  final int? subCategoryId;
  @JsonKey(name: "variant")
  final List<VariantsModel>? variants;

  final int? amount;
  final double? weight;

  @JsonKey(name: "description_en")
  final String? descriptionEn;

  @JsonKey(name: "description_ar")
  final String? descriptionAr;
  final bool? newIn;
  final bool? offer;
  final bool? bestSeller;
  @JsonKey(fromJson: doubleFromString)

  final double? offerPrice;
  @JsonKey(name: "type")
  final String? type; //digital || normal

  const ProductModel({
    this.id,
    this.weight,
    this.brandId,
    this.nameEn,
    this.nameAr,
    this.price,
    this.code,
    this.categoryId,
    this.images,
    this.subCategoryId,
    this.variants,
    this.amount,
    this.descriptionEn,
    this.descriptionAr,
    this.newIn,
    this.offer,
    this.categoryForProduct,
    this.bestSeller,
    this.offerPrice,
    this.brand,
    this.type,
  });

  @override
  List<Object?> get props => [
        nameEn,
        nameAr,
        price,
        code,
        categoryId,
        images,
        subCategoryId,
        variants,
        amount,
        descriptionAr,
        descriptionEn,
        newIn,
        offer,
        offerPrice,
        bestSeller,
        id,
        categoryForProduct,
        brandId,
        brand,
    type,
      ];

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  static double doubleFromString(String? value) {
    if(value==null||value.isEmpty){
      return 0;

    }else{
      return double.parse(value);

    }
  }
}

@JsonSerializable()
class CategoryForProduct extends Equatable {
  @JsonKey(name: "name_en")
  final String? nameEn;

  const CategoryForProduct(this.nameEn, this.nameAr);

  @JsonKey(name: "name_ar")
  final String? nameAr;

  @override
  List<Object?> get props => [nameAr, nameEn];

  factory CategoryForProduct.fromJson(Map<String, dynamic> json) =>
      _$CategoryForProductFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryForProductToJson(this);
}

@JsonSerializable()
class ImageModel extends Equatable {
  final String? url;
  final int? id;

  const ImageModel(this.url, this.id);

  @override
  List<Object?> get props => [url, id];

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class VariantsModel extends Equatable {
  final VariantValuesModel? variantValuesModel;
  final VariantProductModel? variantProductModel;
  final int? id;

  @override
  List<Object?> get props => [id, variantValuesModel, variantProductModel];

  factory VariantsModel.fromJson(Map<String, dynamic> json) => _$VariantsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantsModelToJson(this);

  const VariantsModel(this.variantValuesModel, this.variantProductModel, this.id);
}

@JsonSerializable()
class VariantProductModel extends Equatable {
  final int? id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;

  const VariantProductModel(
    this.id,
    this.nameEn,
    this.nameAr,
  );

  @override
  List<Object?> get props => [id, nameEn, nameAr];

  factory VariantProductModel.fromJson(Map<String, dynamic> json) =>
      _$VariantProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantProductModelToJson(this);
}

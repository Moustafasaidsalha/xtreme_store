import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/product.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class WishlistsModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")
  final WishlistMetaModel? wishlistMetaModel;

  const WishlistsModel(this.message, this.status, this.flag,
      this.wishlistMetaModel);

  @override
  List<Object?> get props => [message, status, flag, wishlistMetaModel];

  factory WishlistsModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistsModelToJson(this);


}

@JsonSerializable()
class WishlistMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<WishListModel>? products;
  final int? totalLength;

  const WishlistMetaModel(this.products, this.totalLength);

  @override
  List<Object?> get props => [products, totalLength];

  factory WishlistMetaModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistMetaModelToJson(this);
}

@JsonSerializable()
class WishListModel extends Equatable {

  final int? id;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "product")
  final WishListProductModel? productModel;

  const WishListModel(this.id, this.productId, this.userId, this.productModel);

  @override
  List<Object?> get props => [id, productId, userId, productModel];

  factory WishListModel.fromJson(Map<String, dynamic> json) =>
      _$WishListModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListModelToJson(this);
}

@JsonSerializable()
class WishListProductModel extends Equatable {
  final int id;
  @JsonKey(name: "name_en")
  final String? nameEn;
  @JsonKey(name: "name_ar")
  final String? nameAr;
  @JsonKey(fromJson: doubleFromString)

  final double? price;
  final String? code;
  @JsonKey(name: "category_id")
  final int? categoryId;

  final List<ImageModel>? images;

  @JsonKey(name: "sub_category_id")
  final int? subCategoryId;
  @JsonKey(name: "variant")
  final List<VariantsModel>? variants;

  final int? amount;

  @JsonKey(name: "description_en")
  final String? descriptionEn;

  @JsonKey(name: "description_ar")
  final String? descriptionAr;
  final String? createdAt;
  final String? updatedAt;
  final bool? newIn;
  final bool? offer;
  final bool? bestSeller;
  @JsonKey(fromJson: doubleFromString)

  final double? offerPrice;


  const WishListProductModel(this.id,
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
      this.bestSeller,
      this.offerPrice,
      this.createdAt,
      this.updatedAt);

  @override
  List<Object?> get props =>
      [
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
        createdAt,
        updatedAt

      ];
  static double doubleFromString(String? value) {
    if(value==null||value.isEmpty){
      return 0;

    }else{
      return double.parse(value);

    }
  }

  factory WishListProductModel.fromJson(Map<String, dynamic> json) =>
      _$WishListProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListProductModelToJson(this);


}

@JsonSerializable()
class ProductIdModel extends Equatable {
  @JsonKey(name: "product_id")
  final int? productID;


  const ProductIdModel(this.productID);

  @override
  List<Object?> get props => [productID];

  factory ProductIdModel.fromJson(Map<String, dynamic> json) =>
      _$ProductIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductIdModelToJson(this);


}

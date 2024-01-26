// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistsModel _$WishlistsModelFromJson(Map<String, dynamic> json) =>
    WishlistsModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : WishlistMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistsModelToJson(WishlistsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.wishlistMetaModel,
    };

WishlistMetaModel _$WishlistMetaModelFromJson(Map<String, dynamic> json) =>
    WishlistMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => WishListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int?,
    );

Map<String, dynamic> _$WishlistMetaModelToJson(WishlistMetaModel instance) =>
    <String, dynamic>{
      'data': instance.products,
      'totalLength': instance.totalLength,
    };

WishListModel _$WishListModelFromJson(Map<String, dynamic> json) =>
    WishListModel(
      json['id'] as int?,
      json['product_id'] as int?,
      json['user_id'] as int?,
      json['product'] == null
          ? null
          : WishListProductModel.fromJson(
              json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishListModelToJson(WishListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'user_id': instance.userId,
      'product': instance.productModel,
    };

WishListProductModel _$WishListProductModelFromJson(
        Map<String, dynamic> json) =>
    WishListProductModel(
      json['id'] as int,
      json['name_en'] as String?,
      json['name_ar'] as String?,
      WishListProductModel.doubleFromString(json['price'] as String?),
      json['code'] as String?,
      json['category_id'] as int?,
      (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['sub_category_id'] as int?,
      (json['variant'] as List<dynamic>?)
          ?.map((e) => VariantsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['amount'] as int?,
      json['description_en'] as String?,
      json['description_ar'] as String?,
      json['newIn'] as bool?,
      json['offer'] as bool?,
      json['bestSeller'] as bool?,
      WishListProductModel.doubleFromString(json['offerPrice'] as String?),
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WishListProductModelToJson(
        WishListProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'price': instance.price,
      'code': instance.code,
      'category_id': instance.categoryId,
      'images': instance.images,
      'sub_category_id': instance.subCategoryId,
      'variant': instance.variants,
      'amount': instance.amount,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'newIn': instance.newIn,
      'offer': instance.offer,
      'bestSeller': instance.bestSeller,
      'offerPrice': instance.offerPrice,
    };

ProductIdModel _$ProductIdModelFromJson(Map<String, dynamic> json) =>
    ProductIdModel(
      json['product_id'] as int?,
    );

Map<String, dynamic> _$ProductIdModelToJson(ProductIdModel instance) =>
    <String, dynamic>{
      'product_id': instance.productID,
    };

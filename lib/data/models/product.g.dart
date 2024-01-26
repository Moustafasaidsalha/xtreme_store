// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      json['status'] as int?,
      json['flag'] as bool?,
      json['message'] as String?,
      json['meta'] == null
          ? null
          : ProductMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'flag': instance.flag,
      'message': instance.message,
      'meta': instance.productMetaModel,
    };

ProductMetaModel _$ProductMetaModelFromJson(Map<String, dynamic> json) =>
    ProductMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$ProductMetaModelToJson(ProductMetaModel instance) =>
    <String, dynamic>{
      'data': instance.products,
      'totalLength': instance.totalLength,
    };

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      json['status'] as int?,
      json['flag'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : ProductDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'flag': instance.flag,
      'message': instance.message,
      'data': instance.productModel,
    };

ProductDataModel _$ProductDataModelFromJson(Map<String, dynamic> json) =>
    ProductDataModel(
      json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      (json['variant'] as List<dynamic>?)
          ?.map((e) => VariantDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDataModelToJson(ProductDataModel instance) =>
    <String, dynamic>{
      'product': instance.productModel,
      'variant': instance.variant,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      brandId: json['brand_id'] as int?,
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
      price: ProductModel.doubleFromString(json['price'] as String?),
      code: json['code'] as String?,
      categoryId: json['category_id'] as int?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategoryId: json['sub_category_id'] as int?,
      variants: (json['variant'] as List<dynamic>?)
          ?.map((e) => VariantsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: json['amount'] as int?,
      descriptionEn: json['description_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      newIn: json['newIn'] as bool?,
      offer: json['offer'] as bool?,
      categoryForProduct: json['categoryForProduct'] == null
          ? null
          : CategoryForProduct.fromJson(
              json['categoryForProduct'] as Map<String, dynamic>),
      bestSeller: json['bestSeller'] as bool?,
      offerPrice: ProductModel.doubleFromString(json['offerPrice'] as String?),
      brand: json['brand'] == null
          ? null
          : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'price': instance.price,
      'code': instance.code,
      'category_id': instance.categoryId,
      'brand_id': instance.brandId,
      'brand': instance.brand,
      'categoryForProduct': instance.categoryForProduct,
      'images': instance.images,
      'sub_category_id': instance.subCategoryId,
      'variant': instance.variants,
      'amount': instance.amount,
      'weight': instance.weight,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'newIn': instance.newIn,
      'offer': instance.offer,
      'bestSeller': instance.bestSeller,
      'offerPrice': instance.offerPrice,
      'type': instance.type,
    };

CategoryForProduct _$CategoryForProductFromJson(Map<String, dynamic> json) =>
    CategoryForProduct(
      json['name_en'] as String?,
      json['name_ar'] as String?,
    );

Map<String, dynamic> _$CategoryForProductToJson(CategoryForProduct instance) =>
    <String, dynamic>{
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      json['url'] as String?,
      json['id'] as int?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
    };

VariantsModel _$VariantsModelFromJson(Map<String, dynamic> json) =>
    VariantsModel(
      json['variantValuesModel'] == null
          ? null
          : VariantValuesModel.fromJson(
              json['variantValuesModel'] as Map<String, dynamic>),
      json['variantProductModel'] == null
          ? null
          : VariantProductModel.fromJson(
              json['variantProductModel'] as Map<String, dynamic>),
      json['id'] as int?,
    );

Map<String, dynamic> _$VariantsModelToJson(VariantsModel instance) =>
    <String, dynamic>{
      'variantValuesModel': instance.variantValuesModel,
      'variantProductModel': instance.variantProductModel,
      'id': instance.id,
    };

VariantProductModel _$VariantProductModelFromJson(Map<String, dynamic> json) =>
    VariantProductModel(
      json['id'] as int?,
      json['name_en'] as String?,
      json['name_ar'] as String?,
    );

Map<String, dynamic> _$VariantProductModelToJson(
        VariantProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannersModel _$BannersModelFromJson(Map<String, dynamic> json) => BannersModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['meta'] == null
          ? null
          : BannerMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BannersModelToJson(BannersModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'meta': instance.bannerMetaModel,
    };

BannerMetaModel _$BannerMetaModelFromJson(Map<String, dynamic> json) =>
    BannerMetaModel(
      (json['data'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalLength'] as int,
    );

Map<String, dynamic> _$BannerMetaModelToJson(BannerMetaModel instance) =>
    <String, dynamic>{
      'data': instance.banners,
      'totalLength': instance.totalLength,
    };

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      json['image'] as String?,
      json['product_id'] as int?,
      json['category_id'] as int?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'product_id': instance.productId,
      'category_id': instance.categoryId,
    };

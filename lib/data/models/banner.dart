import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class BannersModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")

  final BannerMetaModel? bannerMetaModel;

  const BannersModel(this.message, this.status, this.flag, this.bannerMetaModel);

  @override
  List<Object?> get props => [message, status, flag, bannerMetaModel];

  factory BannersModel.fromJson(Map<String, dynamic> json) =>
      _$BannersModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannersModelToJson(this);
}

@JsonSerializable()
class BannerMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<BannerModel>? banners;

  final int totalLength;

  const BannerMetaModel(this.banners, this.totalLength);

  @override
  List<Object?> get props => [banners, totalLength];
  factory BannerMetaModel.fromJson(Map<String, dynamic> json) =>
      _$BannerMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerMetaModelToJson(this);
}


@JsonSerializable()
class BannerModel extends Equatable {
  final String? image;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "category_id")

  final int? categoryId;
  const BannerModel(this.image, this.productId,this.categoryId);

  @override
  List<Object?> get props => [image, productId,categoryId];

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad_screen.g.dart';

@JsonSerializable()
class AdScreensModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "meta")

  final AdScreenMetaModel? adScreenMetaModel;

  const AdScreensModel(this.message, this.status, this.flag, this.adScreenMetaModel);

  @override
  List<Object?> get props => [message, status, flag, adScreenMetaModel];

  factory AdScreensModel.fromJson(Map<String, dynamic> json) =>
      _$AdScreensModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdScreensModelToJson(this);
}

@JsonSerializable()
class AdScreenMetaModel extends Equatable {
  @JsonKey(name: "data")
  final List<AdScreenModel>? adScreens;

  final int totalLength;

  const AdScreenMetaModel(this.adScreens, this.totalLength);

  @override
  List<Object?> get props => [adScreens, totalLength];
  factory AdScreenMetaModel.fromJson(Map<String, dynamic> json) =>
      _$AdScreenMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdScreenMetaModelToJson(this);
}


@JsonSerializable()
class AdScreenModel extends Equatable {
  final String? image;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "category_id")

  final int? categoryId;

  const AdScreenModel(this.image, this.productId,this.categoryId);

  @override
  List<Object?> get props => [image, productId,categoryId];

  factory AdScreenModel.fromJson(Map<String, dynamic> json) =>
      _$AdScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdScreenModelToJson(this);
}
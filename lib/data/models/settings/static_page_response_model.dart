import 'package:json_annotation/json_annotation.dart';

part 'static_page_response_model.g.dart';

@JsonSerializable()
class StaticPageResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final List<StaticPageModel>? data;

  const StaticPageResponseModel({
    this.message,
    this.status,
    this.flag,
    this.data,
  });

  factory StaticPageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StaticPageResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$StaticPageResponseModelToJson(this);
}

@JsonSerializable()
class StaticPageModel {
  @JsonKey(name: "title_en")
  final String? titleEN;
  @JsonKey(name: "title_ar")
  final String? titleAR;
  @JsonKey(name: "description_en")
  final String? descriptionEN;
  @JsonKey(name: "description_ar")
  final String? descriptionAR;
  @JsonKey(name: "type")
  final String? type;

  const StaticPageModel({
    this.titleEN,
    this.titleAR,
    this.descriptionEN,
    this.descriptionAR,
    this.type,
  });

  factory StaticPageModel.fromJson(Map<String, dynamic> json) => _$StaticPageModelFromJson(json);
  Map<String, dynamic> toJson() => _$StaticPageModelToJson(this);
}

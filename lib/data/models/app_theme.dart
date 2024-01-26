import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_theme.g.dart';

@JsonSerializable()
class AppThemeModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final AppThemeDataModel? appThemeDataModel;

  const AppThemeModel(this.message, this.status, this.flag,
      this.appThemeDataModel);

  @override
  List<Object?> get props => [message, status, flag, appThemeDataModel];

  factory AppThemeModel.fromJson(Map<String, dynamic> json) =>
      _$AppThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeModelToJson(this);
}

@JsonSerializable()
class AppThemeDataModel extends Equatable {
  @JsonKey(name: "mobile_logo")
  final String? mobileLogo;

  @JsonKey(name: "main_color")
  final String? mainColor;

  @JsonKey(name: "label_color")
  final String? labelColor;


  const AppThemeDataModel(this.mobileLogo, this.mainColor, this.labelColor);

  @override
  List<Object?> get props => [mobileLogo, mainColor, labelColor];

  factory AppThemeDataModel.fromJson(Map<String, dynamic> json) =>
      _$AppThemeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeDataModelToJson(this);
}


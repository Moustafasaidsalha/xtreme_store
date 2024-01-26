import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';

part 'setting.g.dart';

@JsonSerializable()
class SettingsModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final SettingModel? settingModel;

  const SettingsModel(this.message, this.status, this.flag, this.settingModel);

  @override
  List<Object?> get props => [message, status, flag, settingModel];
  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}

@JsonSerializable()
class SettingModel extends Equatable {
  final String? snapchat;
  final String? facebook;
  final String? instagram;
  final String? whatsapp;
  final String? twitter;
  final String? tiktok;


  const SettingModel(this.snapchat, this.facebook, this.instagram,
      this.whatsapp,
      this.twitter, this.tiktok);

  @override
  List<Object?> get props =>
      [snapchat, facebook, instagram, whatsapp, twitter, tiktok,];

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}

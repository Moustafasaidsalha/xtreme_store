import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'area_model.dart';

part 'area_response_model.g.dart';

@JsonSerializable()
class AreaResponseModel extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final List<AreaModel>? areaList;

  const AreaResponseModel({this.message, this.status, this.flag, this.areaList});

  @override
  List<Object?> get props => [message, status, flag, areaList];

  factory AreaResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AreaResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaResponseModelToJson(this);
}

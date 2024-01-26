import 'package:json_annotation/json_annotation.dart';

part 'interval_hours_model.g.dart';

@JsonSerializable()
class IntervalHoursResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final List<IntervalHoursModel>? intervalHoursDataModel;

  const IntervalHoursResponseModel({
    this.message,
    this.status,
    this.flag,
    this.intervalHoursDataModel,
  });

  factory IntervalHoursResponseModel.fromJson(Map<String, dynamic> json) =>
      _$IntervalHoursResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalHoursResponseModelToJson(this);
}

@JsonSerializable()
class IntervalHoursModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "count")
  final int? count;
  @JsonKey(name: "from")
  final String? from;
  @JsonKey(name: "to")
  final String? to;
  @JsonKey(name: "isComplete")
  final bool? isComplete;

  const IntervalHoursModel({this.id, this.count, this.from, this.to,this.isComplete,});

  factory IntervalHoursModel.fromJson(Map<String, dynamic> json) =>
      _$IntervalHoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntervalHoursModelToJson(this);
}

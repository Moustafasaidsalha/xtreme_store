import 'package:json_annotation/json_annotation.dart';

part 'blocked_dates_model.g.dart';

@JsonSerializable()
class BlockDatesResponseModel {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final BlockDateDataModel? blockDateDataModel;


  const BlockDatesResponseModel({
    this.message,
    this.status,
    this.flag,
    this.blockDateDataModel,
  });

  factory BlockDatesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BlockDatesResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlockDatesResponseModelToJson(this);
}

@JsonSerializable()
class BlockDateDataModel {
  @JsonKey(name: "blockDate")
  final List<BlockDateModel>? blockDates;
  @JsonKey(name: "day")
  final List<DayOffModel>? daysOff;

  const BlockDateDataModel({this.blockDates, this.daysOff});

  factory BlockDateDataModel.fromJson(Map<String, dynamic> json) => _$BlockDateDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlockDateDataModelToJson(this);
}

@JsonSerializable()
class BlockDateModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "date")
  final String? date;

  const BlockDateModel({this.id, this.date});

  factory BlockDateModel.fromJson(Map<String, dynamic> json) => _$BlockDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlockDateModelToJson(this);
}

@JsonSerializable()
class DayOffModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "isOpen")
  final bool? isOpen;

  const DayOffModel({this.id, this.name, this.isOpen});

  factory DayOffModel.fromJson(Map<String, dynamic> json) => _$DayOffModelFromJson(json);
  Map<String, dynamic> toJson() => _$DayOffModelToJson(this);
}

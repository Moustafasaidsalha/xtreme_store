import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'area_model.g.dart';

@JsonSerializable()
class AreaModel extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name_ar")
  final String? areaNameAR;
  @JsonKey(name: "name_en")
  final String? areaNameEN;
  @JsonKey(name: "country_id")
  final int? countryID;

  const AreaModel({
    this.id,
    this.areaNameAR,
    this.areaNameEN,
    this.countryID,
  });

  @override
  List<Object?> get props => [
        id,
        areaNameAR,
        areaNameEN,
        countryID,
      ];

  factory AreaModel.fromJson(Map<String, dynamic> json) => _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);
}

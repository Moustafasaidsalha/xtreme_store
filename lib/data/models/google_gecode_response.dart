
import 'package:json_annotation/json_annotation.dart';
part 'google_gecode_response.g.dart';

@JsonSerializable()
class GoogleGecodeResponse {
  List<Results>? results;
  String? status;

  GoogleGecodeResponse({
    this.results,
    this.status,
  });
  factory GoogleGecodeResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleGecodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleGecodeResponseToJson(this);
}

@JsonSerializable()
class Results {
  @JsonKey(name: "formatted_address")
  String? formattedAddress;

  @JsonKey(name: "place_id")
  String? placeId;

  Results({
    this.formattedAddress,
    this.placeId,
  });

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

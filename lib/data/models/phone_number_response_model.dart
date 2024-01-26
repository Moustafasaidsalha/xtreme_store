import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_number_response_model.g.dart';

@JsonSerializable()
class PhoneNumberResponseModel extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final List<PhoneNumberModel>? phoneNumbers;

  const PhoneNumberResponseModel({this.message, this.status, this.flag, this.phoneNumbers});

  @override
  List<Object?> get props => [message, status, flag];

  factory PhoneNumberResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberResponseModelToJson(this);
}

@JsonSerializable()
class PhoneNumberModel extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country_code")
  final String? countryCode;
  @JsonKey(name: "phone")
  final String? phoneNumber;

  const PhoneNumberModel({this.id, this.countryCode, this.phoneNumber});

  @override
  List<Object?> get props => [id, countryCode, phoneNumber];

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) => _$PhoneNumberModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberModelToJson(this);
}

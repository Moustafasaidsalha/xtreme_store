import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:extreme_store/data/models/profile.dart';

part 'sign_up_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel extends Equatable {
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserAccessData? userAccessData;
  @JsonKey(name: "accessToken")
  final String? accessToken;

  const SignUpResponseModel({
    this.flag,
    this.status,
    this.message,
    this.userAccessData,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
    flag,
    status,
    message,
    userAccessData,
    accessToken,
  ];

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => _$SignUpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseModelToJson(this);
}



@JsonSerializable()
class UserAccessData extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "f_name")
  final String? firstName;
  @JsonKey(name: "l_name")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "user_phones")
  final List<PhoneModel>? phones;

  const UserAccessData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phones,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phones,
  ];

  factory UserAccessData.fromJson(Map<String, dynamic> json) => _$UserAccessDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccessDataToJson(this);
}
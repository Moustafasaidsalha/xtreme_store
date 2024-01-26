import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request_model.g.dart';

@JsonSerializable()
class UserRequestModel extends Equatable {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "f_name")
  final String? firstName;
  @JsonKey(name: "l_name")
  final String? lastName;

  const UserRequestModel({
    this.email,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props => [email, firstName, lastName];

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable()
class UsersModel extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final UserModel? user;
  @JsonKey(name: "accessToken")
  final String accessToken;

  const UsersModel(this.message,
      this.status,
      this.flag,
      this.user,
      this.accessToken,);

  @override
  List<Object?> get props => [message, status, flag, user, accessToken];

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "f_name")
  final String? firstName;
  @JsonKey(name: "l_name")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;

  const UserModel(this.email,
      this.phone,
      this.id,
      this.firstName,
      this.lastName,);

  @override
  List<Object?> get props => [email, phone, id, firstName, lastName];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class EditProfileModel extends Equatable {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "f_name")
  final String? firstName;
  @JsonKey(name: "l_name")
  final String? lastName;


  const EditProfileModel(this.email, this.firstName, this.lastName);

  @override
  List<Object?> get props => [firstName, lastName, email];
  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileModelToJson(this);
}
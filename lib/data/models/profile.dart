import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class ProfilesModel extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "flag")
  final bool? flag;
  @JsonKey(name: "data")
  final ProfileModel? userProfile;



const ProfilesModel(this.message, this.status, this.flag, this.userProfile);

  @override
  List<Object?> get props => [message, status, flag, userProfile];

  factory ProfilesModel.fromJson(Map<String, dynamic> json) =>
      _$ProfilesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilesModelToJson(this);
}

// @JsonSerializable()
// class ProfileMetaModel extends Equatable {
//   @JsonKey(name: "data")
//   final List<ProfileModel>? user;
//   final int totalLength;
//
//   const ProfileMetaModel(this.user, this.totalLength);
//
//   @override
//   List<Object?> get props => [user, totalLength];
//
//   factory ProfileMetaModel.fromJson(Map<String, dynamic> json) =>
//       _$ProfileMetaModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ProfileMetaModelToJson(this);
// }

@JsonSerializable()
class ProfileModel extends Equatable {
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

  const ProfileModel(this.email,
      this.phones,
      this.id,
      this.firstName,
      this.lastName,);

  @override
  List<Object?> get props => [email, phones, id, firstName, lastName];

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class PhoneModel extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country_code")
  final String? countryCode;
  final String? phone;
  @JsonKey(name: "is_default")
  final bool? isDefault;

  const PhoneModel(this.id, this.countryCode, this.phone,this.isDefault);

  @override
  List<Object?> get props => [id, countryCode, phone,isDefault];
  factory PhoneModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneModelToJson(this);
}
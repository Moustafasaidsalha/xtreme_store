import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'area_model.dart';

part 'addresses_response_model.g.dart';

@JsonSerializable()
class AddressesResponseModel extends Equatable {
  final String? message;
  final int? status;
  final bool? flag;
  @JsonKey(name: "data")
  final List<AddressModel>? addresses;

  const AddressesResponseModel(this.message, this.status, this.flag, this.addresses);

  @override
  List<Object?> get props => [message, status, flag, addresses];

  factory AddressesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddressesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesResponseModelToJson(this);
}

@JsonSerializable()
class AddressModel extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country")
  final CountryAddressModel? countryAddressModel;
  @JsonKey(name: "user_phone")
  final UserPhoneAddressModel? userPhoneAddressModel;
  @JsonKey(name: "addressName")
  final String? addressName;
  @JsonKey(name: "area")
  final AreaModel? areaModel;
  @JsonKey(name: "block")
  final String? block;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "avenue")
  final String? avenue;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "houseNumber")
  final String? houseNumber;
  @JsonKey(name: "aptNumber")
  final String? aptNumber;
  @JsonKey(name: "buildingNumber")
  final String? buildingNumber;
  @JsonKey(name: "floorNumber")
  final String? floorNumber;
  @JsonKey(name: "officeNumber")
  final String? officeNumber;
  @JsonKey(name: "otherInstructions")
  final String? otherInstructions;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "phone_id")
  final int? phoneID;
  @JsonKey(name: "is_default")
  final bool? isDefault;

  const AddressModel({
    this.id,
    this.addressName,
    this.areaModel,
    this.block,
    this.street,
    this.avenue,
    this.type,
    this.buildingNumber,
    this.floorNumber,
    this.officeNumber,
    this.otherInstructions,
    this.longitude,
    this.latitude,
    this.countryAddressModel,
    this.houseNumber,
    this.userPhoneAddressModel,
    this.aptNumber,
    this.phoneID,
    this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        addressName,
        areaModel,
        block,
        street,
        avenue,
        type,
        buildingNumber,
        floorNumber,
        officeNumber,
        otherInstructions,
        countryAddressModel,
        houseNumber,
        userPhoneAddressModel,
        aptNumber,
        phoneID,
        isDefault,
      ];

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class AddAddressModel extends Equatable {
  @JsonKey(name: "country_id")
  final int? countryID;
  @JsonKey(name: "area_id")
  final int? areaID;
  @JsonKey(name: "addressName")
  final String? addressName;
  @JsonKey(name: "block")
  final String? block;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "avenue")
  final String? avenue;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "buildingNumber")
  final String? buildingNumber;
  @JsonKey(name: "floorNumber")
  final String? floorNumber;
  @JsonKey(name: "officeNumber")
  final String? officeNumber;
  @JsonKey(name: "houseNumber")
  final String? houseNumber;
  @JsonKey(name: "aptNumber")
  final String? aptNumber;
  @JsonKey(name: "otherInstructions")
  final String? otherInstructions;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "phone_id")
  final int? phoneID;

  const AddAddressModel({
    this.countryID,
    this.areaID,
    this.addressName,
    this.block,
    this.street,
    this.avenue,
    this.type,
    this.buildingNumber,
    this.floorNumber,
    this.officeNumber,
    this.otherInstructions,
    this.longitude,
    this.latitude,
    this.aptNumber,
    this.houseNumber,
    this.phoneID,
  });

  @override
  List<Object?> get props => [
        countryID,
        areaID,
        addressName,
        block,
        street,
        avenue,
        type,
        buildingNumber,
        floorNumber,
        officeNumber,
        otherInstructions,
        phoneID,
      ];

  factory AddAddressModel.fromJson(Map<String, dynamic> json) => _$AddAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressModelToJson(this);
  Map<String, dynamic> houseToJson() => <String, dynamic>{
        'country_id': countryID,
        'area_id': areaID,
        'addressName': addressName,
        'block': block,
        'street': street,
        'avenue': avenue,
        'type': type,
        // 'buildingNumber': buildingNumber,
        // 'floorNumber': floorNumber,
        // 'officeNumber': officeNumber,
        'houseNumber': houseNumber,
        // 'aptNumber': aptNumber,
        'otherInstructions': otherInstructions,
        'longitude': longitude,
        'latitude': latitude,
        'phone_id': phoneID,
      };
  Map<String, dynamic> officeToJson() => <String, dynamic>{
        'country_id': countryID,
        'area_id': areaID,
        'addressName': addressName,
        'block': block,
        'street': street,
        'avenue': avenue,
        'type': type,
        'buildingNumber': buildingNumber,
        'floorNumber': floorNumber,
        'officeNumber': officeNumber,
        // 'houseNumber': houseNumber,
        // 'aptNumber': aptNumber,
        'otherInstructions': otherInstructions,
        'longitude': longitude,
        'latitude': latitude,
        'phone_id': phoneID,
      };

  Map<String, dynamic> buildingToJson() => <String, dynamic>{
        'country_id': countryID,
        'area_id': areaID,
        'addressName': addressName,
        'block': block,
        'street': street,
        'avenue': avenue,
        'type': type,
        'buildingNumber': buildingNumber,
        'floorNumber': floorNumber,
        // 'officeNumber': officeNumber,
        // 'houseNumber': houseNumber,
        'aptNumber': aptNumber,
        'otherInstructions': otherInstructions,
        'longitude': longitude,
        'latitude': latitude,
        'phone_id': phoneID,
      };
}

@JsonSerializable()
class CountryAddressModel {
  @JsonKey(name: "name_en")
  final String? nameAR;
  @JsonKey(name: "name_ar")
  final String? nameEN;

  CountryAddressModel({this.nameAR, this.nameEN});

  factory CountryAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CountryAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryAddressModelToJson(this);
}

@JsonSerializable()
class UserPhoneAddressModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country_code")
  final String? countryCode;
  @JsonKey(name: "phone")
  final String? phone;

  UserPhoneAddressModel({this.id, this.countryCode, this.phone});

  factory UserPhoneAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserPhoneAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPhoneAddressModelToJson(this);
}

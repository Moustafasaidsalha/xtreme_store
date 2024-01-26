// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressesResponseModel _$AddressesResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddressesResponseModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressesResponseModelToJson(
        AddressesResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.addresses,
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as int?,
      addressName: json['addressName'] as String?,
      areaModel: json['area'] == null
          ? null
          : AreaModel.fromJson(json['area'] as Map<String, dynamic>),
      block: json['block'] as String?,
      street: json['street'] as String?,
      avenue: json['avenue'] as String?,
      type: json['type'] as String?,
      buildingNumber: json['buildingNumber'] as String?,
      floorNumber: json['floorNumber'] as String?,
      officeNumber: json['officeNumber'] as String?,
      otherInstructions: json['otherInstructions'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      countryAddressModel: json['country'] == null
          ? null
          : CountryAddressModel.fromJson(
              json['country'] as Map<String, dynamic>),
      houseNumber: json['houseNumber'] as String?,
      userPhoneAddressModel: json['user_phone'] == null
          ? null
          : UserPhoneAddressModel.fromJson(
              json['user_phone'] as Map<String, dynamic>),
      aptNumber: json['aptNumber'] as String?,
      phoneID: json['phone_id'] as int?,
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.countryAddressModel,
      'user_phone': instance.userPhoneAddressModel,
      'addressName': instance.addressName,
      'area': instance.areaModel,
      'block': instance.block,
      'street': instance.street,
      'avenue': instance.avenue,
      'type': instance.type,
      'houseNumber': instance.houseNumber,
      'aptNumber': instance.aptNumber,
      'buildingNumber': instance.buildingNumber,
      'floorNumber': instance.floorNumber,
      'officeNumber': instance.officeNumber,
      'otherInstructions': instance.otherInstructions,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'phone_id': instance.phoneID,
      'is_default': instance.isDefault,
    };

AddAddressModel _$AddAddressModelFromJson(Map<String, dynamic> json) =>
    AddAddressModel(
      countryID: json['country_id'] as int?,
      areaID: json['area_id'] as int?,
      addressName: json['addressName'] as String?,
      block: json['block'] as String?,
      street: json['street'] as String?,
      avenue: json['avenue'] as String?,
      type: json['type'] as String?,
      buildingNumber: json['buildingNumber'] as String?,
      floorNumber: json['floorNumber'] as String?,
      officeNumber: json['officeNumber'] as String?,
      otherInstructions: json['otherInstructions'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      aptNumber: json['aptNumber'] as String?,
      houseNumber: json['houseNumber'] as String?,
      phoneID: json['phone_id'] as int?,
    );

Map<String, dynamic> _$AddAddressModelToJson(AddAddressModel instance) =>
    <String, dynamic>{
      'country_id': instance.countryID,
      'area_id': instance.areaID,
      'addressName': instance.addressName,
      'block': instance.block,
      'street': instance.street,
      'avenue': instance.avenue,
      'type': instance.type,
      'buildingNumber': instance.buildingNumber,
      'floorNumber': instance.floorNumber,
      'officeNumber': instance.officeNumber,
      'houseNumber': instance.houseNumber,
      'aptNumber': instance.aptNumber,
      'otherInstructions': instance.otherInstructions,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'phone_id': instance.phoneID,
    };

CountryAddressModel _$CountryAddressModelFromJson(Map<String, dynamic> json) =>
    CountryAddressModel(
      nameAR: json['name_en'] as String?,
      nameEN: json['name_ar'] as String?,
    );

Map<String, dynamic> _$CountryAddressModelToJson(
        CountryAddressModel instance) =>
    <String, dynamic>{
      'name_en': instance.nameAR,
      'name_ar': instance.nameEN,
    };

UserPhoneAddressModel _$UserPhoneAddressModelFromJson(
        Map<String, dynamic> json) =>
    UserPhoneAddressModel(
      id: json['id'] as int?,
      countryCode: json['country_code'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserPhoneAddressModelToJson(
        UserPhoneAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_code': instance.countryCode,
      'phone': instance.phone,
    };

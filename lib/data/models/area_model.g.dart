// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) => AreaModel(
      id: json['id'] as int?,
      areaNameAR: json['name_ar'] as String?,
      areaNameEN: json['name_en'] as String?,
      countryID: json['country_id'] as int?,
    );

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) => <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.areaNameAR,
      'name_en': instance.areaNameEN,
      'country_id': instance.countryID,
    };

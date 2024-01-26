// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaResponseModel _$AreaResponseModelFromJson(Map<String, dynamic> json) =>
    AreaResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      areaList: (json['data'] as List<dynamic>?)
          ?.map((e) => AreaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaResponseModelToJson(AreaResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.areaList,
    };

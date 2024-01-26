// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_dates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockDatesResponseModel _$BlockDatesResponseModelFromJson(
        Map<String, dynamic> json) =>
    BlockDatesResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      blockDateDataModel: json['data'] == null
          ? null
          : BlockDateDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockDatesResponseModelToJson(
        BlockDatesResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.blockDateDataModel,
    };

BlockDateDataModel _$BlockDateDataModelFromJson(Map<String, dynamic> json) =>
    BlockDateDataModel(
      blockDates: (json['blockDate'] as List<dynamic>?)
          ?.map((e) => BlockDateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      daysOff: (json['day'] as List<dynamic>?)
          ?.map((e) => DayOffModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlockDateDataModelToJson(BlockDateDataModel instance) =>
    <String, dynamic>{
      'blockDate': instance.blockDates,
      'day': instance.daysOff,
    };

BlockDateModel _$BlockDateModelFromJson(Map<String, dynamic> json) =>
    BlockDateModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$BlockDateModelToJson(BlockDateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
    };

DayOffModel _$DayOffModelFromJson(Map<String, dynamic> json) => DayOffModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isOpen: json['isOpen'] as bool?,
    );

Map<String, dynamic> _$DayOffModelToJson(DayOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isOpen': instance.isOpen,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntervalHoursResponseModel _$IntervalHoursResponseModelFromJson(
        Map<String, dynamic> json) =>
    IntervalHoursResponseModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      flag: json['flag'] as bool?,
      intervalHoursDataModel: (json['data'] as List<dynamic>?)
          ?.map((e) => IntervalHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IntervalHoursResponseModelToJson(
        IntervalHoursResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.intervalHoursDataModel,
    };

IntervalHoursModel _$IntervalHoursModelFromJson(Map<String, dynamic> json) =>
    IntervalHoursModel(
      id: json['id'] as int?,
      count: json['count'] as int?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      isComplete: json['isComplete'] as bool?,
    );

Map<String, dynamic> _$IntervalHoursModelToJson(IntervalHoursModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'from': instance.from,
      'to': instance.to,
      'isComplete': instance.isComplete,
    };

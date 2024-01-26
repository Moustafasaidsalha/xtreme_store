// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseModel _$OrderResponseModelFromJson(Map<String, dynamic> json) =>
    OrderResponseModel(
      json['message'] as String?,
      json['status'] as int?,
      json['flag'] as bool?,
      json['data'] as String?,
    );

Map<String, dynamic> _$OrderResponseModelToJson(OrderResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'flag': instance.flag,
      'data': instance.data,
    };

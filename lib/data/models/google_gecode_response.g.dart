// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_gecode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleGecodeResponse _$GoogleGecodeResponseFromJson(
        Map<String, dynamic> json) =>
    GoogleGecodeResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GoogleGecodeResponseToJson(
        GoogleGecodeResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'status': instance.status,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      formattedAddress: json['formatted_address'] as String?,
      placeId: json['place_id'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'place_id': instance.placeId,
    };

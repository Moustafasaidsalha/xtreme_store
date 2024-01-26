import 'package:dio/dio.dart';
import 'package:extreme_store/data/models/google_gecode_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_maps_data_source.g.dart';

@RestApi(baseUrl: "https://maps.googleapis.com")
abstract class GoogleMapDataSource {
  factory GoogleMapDataSource(Dio dio, {String baseUrl}) = _GoogleMapDataSource;

  @POST("/maps/api/geocode/json")
  Future<GoogleGecodeResponse> getFullAddress({
    @Query("key") String apiKey = 'AIzaSyBcd3p9Z6kDIOMwb8pDKl8zAtmA5OOSvp8',
    @Query("language") required String lang,
    @Query("latlng") required String latLang,
    @Query("result_type") String resultType = 'route',
  });
}

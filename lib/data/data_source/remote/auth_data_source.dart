import 'package:dio/dio.dart';
import 'package:extreme_store/data/models/auth_response.dart';
import 'package:extreme_store/data/models/users_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/response.dart';
import '../../models/sign_up_response_model.dart';
import '../../models/user_request_model.dart';

part 'auth_data_source.g.dart';

@RestApi(baseUrl: "https://back.xtremestorekw.com/api/")
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  // @POST("users/signup")
  // Future<AuthResponse> signUp({
  //   @Query("lang") required String lang,
  //   @Field("phone") required String phoneNumber,
  //   @Field("country_code") required String countryCode,
  // });
  @POST("users/signup")
  Future<SignUpResponseModel> signUp({
    @Field("f_name") required String firstName,
    @Field("l_name") required String lastName,
    @Field("email") required String email,
    @Field("country_code") required String countryCode,
    @Field("phone") required String phone,
    @Field("password") required String pinCode,
  });

  @PUT("users")
  Future<AuthResponse> addUserData({
    @Header('Authorization') required String token,
    @Body() required UserRequestModel requestModel,
  });
  // @POST("users/login")
  // Future<AuthResponse> login({
  //   @Query("lang") required String lang,
  //   @Field("phone") required String phoneNumber,
  //   @Field("country_code") required String countryCode,
  // });
  @POST("users/login")
  Future<SignUpResponseModel> login({
    @Field("country_code") required String countryCode,
    @Field("phone") required String phoneNumber,
    @Field("password") required String pinCode,
  });

  @POST("users/verify")
  Future<UsersModel> verifyUser({
    @Field("phone") required String phoneNumber,
    @Field("country_code") required String countryCode,
    @Field("code") required String code,
    @Field("type") required String type,
  });
  @POST("users/resetPassword")
  Future<AuthResponse> resetPassword({
    @Field("email") required String email,
  });
  @POST("users/resetPassword/checkCode")
  Future<AuthResponse> checkCode({
    @Field("email") required String email,
    @Field("code") required String code,
  });
  @POST("users/resetPassword/newPassword")
  Future<AuthResponse> addNewPassword({
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("code") required String code,
  });
  @PUT("users/changePassword")
  Future<AuthResponse> changePinCode({
    @Header('Authorization')  required String token,
    @Field("old_password")    required String oldPin,
    @Field("new_password")    required String newPin,
  });
  @POST("users/logout")
  Future<ResponseModel> logout({
    @Header('Authorization') required String token,
  });
  @DELETE("users/delete")
  Future<ResponseModel> deleteUser({
    @Header('Authorization') required String token,
  });
}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:extreme_store/app/failure/failure.dart';
import 'package:extreme_store/data/data_source/remote/auth_data_source.dart';

import 'package:extreme_store/data/models/auth_response.dart';
import 'package:extreme_store/data/models/user_request_model.dart';
import 'package:extreme_store/data/models/users_model.dart';

import '../../domain/repositories/auth_repo.dart';
import '../../domain/repositories/user_preference_repo.dart';
import '../models/response.dart';
import '../models/sign_up_response_model.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;
  final UserPreferenceRepo userPreferenceRepo;

  AuthRepoImpl({required this.authDataSource,required this.userPreferenceRepo});

  // @override
  // Future<Either<Failure, AuthResponse>> signUp({
  //   required String phoneNumber,
  //   required String countryCode,
  // }) async {
  //   try {
  //     final response = await authDataSource.signUp(
  //       lang: 'ar',
  //       phoneNumber: phoneNumber,
  //       countryCode: countryCode,
  //     );
  //
  //     if (kDebugMode) {
  //       print(response);
  //     }
  //     if (response.flag ?? false) {
  //       return Right(response);
  //     } else {
  //       return left(ServerFailure(response.message ?? ''));
  //     }
  //   } on DioException catch (e) {
  //     AuthResponse authResponse = AuthResponse.fromJson(
  //       e.response?.data as Map<String, dynamic>,
  //     );
  //     return left(ServerFailure(authResponse.message ?? ''));
  //   }
  // }
  @override
  Future<Either<Failure, SignUpResponseModel>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      final response = await authDataSource.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        countryCode: countryCode,
        phone: phoneNumber,
        pinCode: pin,
      );

      if (kDebugMode) {
        print(response);
      }
      if (response.flag ?? false) {
        return Right(response);
      } else {
        return left(ServerFailure(response.message ?? ''));
      }
    } on DioException catch (e) {
      log("DioException $e");
      log("DioException ${e.message}");
      log("DioException ${e.response}");
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  // @override
  // Future<Either<Failure, AuthResponse>> login({
  //   required String phoneNumber,
  //   required String countryCode,
  // }) async {
  //   try {
  //     final response = await authDataSource.login(
  //       lang: 'ar',
  //       phoneNumber: phoneNumber,
  //       countryCode: countryCode,
  //     );
  //     return Right(response);
  //   } on DioException catch (e) {
  //     AuthResponse authResponse = AuthResponse.fromJson(
  //       e.response?.data as Map<String, dynamic>,
  //     );
  //     return left(ServerFailure(authResponse.message ?? ''));
  //   }
  // }

  @override
  Future<Either<Failure, SignUpResponseModel>> login({
    required String phoneNumber,
    required String countryCode,
    required String pin,
  }) async {
    try {
      final response = await authDataSource.login(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        pinCode: pin
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> verifyUser({
    required String phoneNumber,
    required String countryCode,
    required String code,
    required String type,
  }) async {
    try {
      final response = await authDataSource.verifyUser(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        code: code,
        type: type,
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resetPassword({
    required String email,
  }) async {
    try {
      final response = await authDataSource.resetPassword(
        email: email,
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> checkResetPasswordCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await authDataSource.checkCode(
        email: email,
        code: code,
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> addNewPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      final response = await authDataSource.addNewPassword(
        email: email,
        password: password,
        code: code,
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> changePinCode({
    required String oldPin,
    required String newPin,
  }) async{
    try {
      var token = userPreferenceRepo.getAccessToken();
      final response = await authDataSource.changePinCode(
        token: token,
        oldPin: oldPin,
        newPin: newPin,
      );
      if(response.flag ?? false){
        return Right(response);
      }else{
        return Left(ServerFailure(response.message ?? ''));
      }
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }

  }

  @override
  Future<Either<Failure, AuthResponse>> completeUserData({
    required String accessToken,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await authDataSource.addUserData(
        token: accessToken,
        requestModel: UserRequestModel(email: email, firstName: firstName, lastName: lastName),
      );
      return Right(response);
    } on DioException catch (e) {
      AuthResponse authResponse = AuthResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return left(ServerFailure(authResponse.message ?? ''));
    }
  }
  @override
  Future<Either<Failure, ResponseModel>> deleteUser() async {
    try {
      var token = userPreferenceRepo.getAccessToken();
      final res = await authDataSource.deleteUser(token: token);
      if ((res.flag ?? false) == true) {
        await userPreferenceRepo.insertAccessToken(value: '');
        return Right(res);
      } else {
        return Left(ServerFailure(res.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> logout() async {
    try {
      var token = userPreferenceRepo.getAccessToken();
      final res = await authDataSource.logout(token: token);
      if ((res.flag ?? false) == true) {
        await userPreferenceRepo.insertAccessToken(value: '');
        return Right(res);
      } else {
        return Left(ServerFailure(res.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? ''));
    }
  }
}

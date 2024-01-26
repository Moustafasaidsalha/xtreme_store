import 'package:dartz/dartz.dart';
import 'package:extreme_store/data/models/auth_response.dart';
import 'package:extreme_store/data/models/sign_up_response_model.dart';

import '../../app/failure/failure.dart';
import '../../data/models/response.dart';
import '../../data/models/users_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignUpResponseModel>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String phoneNumber,
    required String pin,
  });
  Future<Either<Failure, SignUpResponseModel>> login({
    required String phoneNumber,
    required String countryCode,
    required String pin,
  });

  Future<Either<Failure, UsersModel>> verifyUser({
    required String phoneNumber,
    required String countryCode,
    required String code,
    required String type,
  });
  Future<Either<Failure, AuthResponse>> completeUserData({
    required String accessToken,
    String? email,
    String? firstName,
    String? lastName,
  });
  Future<Either<Failure, AuthResponse>> resetPassword({
    required String email,
  });
  Future<Either<Failure, AuthResponse>> checkResetPasswordCode({
    required String email,
    required String code,
  });
  Future<Either<Failure, AuthResponse>> addNewPassword({
    required String email,
    required String password,
    required String code,
  });
  // Future<Either<Failure, UserCredential>> signInWithGoogleProvider();
  // Future<Either<Failure, UserCredential>> signInWithAppleProvider();
  // Future<Either<Failure, bool>> verifyUserEmail(User user);
  // Future<Either<Failure, bool>> addUserName(User user, String name);
  // Future<Either<Failure, bool>> forgetPassword(String email);

  Future<Either<Failure, AuthResponse>> changePinCode({
    required String oldPin,
    required String newPin,
  });
  Future<Either<Failure, ResponseModel>> deleteUser();
  Future<Either<Failure, ResponseModel>> logout();
}

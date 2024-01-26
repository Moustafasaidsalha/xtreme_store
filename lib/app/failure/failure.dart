import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

abstract class CustomFailure extends Equatable {
  @override
  List<Object?> get props => [];
}

// class AuthFailure extends Failure {
//   final String? message;
//   final String? code;
//
//   AuthFailure({this.message, this.code});
//   @override
//   List<Object?> get props => [message, code];
// }
//
// class FileFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DataFailure extends Failure {
  final int? failureCode;
  final String? messageD;
  const DataFailure({this.failureCode, this.messageD}) : super(messageD ?? '');
}

// class ExceptionFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }
//

class LocalDataBaseFailure extends CustomFailure {}

//
// class FirebaseFailure extends Failure {
//   final String message;
//   final String code;
//
//   FirebaseFailure({
//     required this.message,
//     required this.code,
//   });
//   @override
//   List<Object?> get props => [message, code];
// }
//
class ServerException implements Exception {}

//
class LocalDatabaseException implements Exception {}

import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}

// Firebase Exceptions
class FirebaseAuthException extends ServerException {
  const FirebaseAuthException([message])
      : super("Firebase Authentication Error");
}

class FirebaseNetworkException extends ServerException {
  const FirebaseNetworkException([message]) : super("Firebase Network Error");
}

class FirebaseStorageException extends ServerException {
  const FirebaseStorageException([message]) : super("Firebase Storage Error");
}

class FirebaseDatabaseException extends ServerException {
  const FirebaseDatabaseException([message]) : super("Firebase Database Error");
}

class FirebaseTimeoutException extends ServerException {
  const FirebaseTimeoutException([message]) : super("Firebase Timeout Error");
}

class FirebaseUnknownException extends ServerException {
  const FirebaseUnknownException([message]) : super("Unknown Firebase Error");
}

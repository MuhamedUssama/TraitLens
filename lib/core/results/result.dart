import '../errors/exceptions.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  T? data;

  Success(this.data);
}

class Fail<T> extends Result<T> {
  ServerException? exception;
  Fail(this.exception);
}

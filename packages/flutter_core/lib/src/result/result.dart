import 'package:flutter_core/src/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

export 'package:flutter_core/src/failure/failure.dart';
export 'package:fpdart/fpdart.dart';

typedef FutureResult<T> = Future<Result<T>>;

class Result<T> {
  final Either<Failure, T> value;

  factory Result.failure(Failure failure) => Result._(Left(failure));

  factory Result.success(T data) => Result._(Right(data));

  const Result._(this.value);

  bool get isFailure => value.isLeft();
  bool get isSuccess => value.isRight();

  Failure getFailure() =>
      value.getLeft().getOrElse(() => throw Exception('No Failure present'));
  T getSuccess() =>
      value.getRight().getOrElse(() => throw Exception('No Success present'));
}

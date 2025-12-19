import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_core/src/result/result.dart';

/// Generic error message used when no specific error message is available.
const kGenericErrorMessage = 'An unexpected error occurred. Please try again.';

/// Base exception handler mixin that provides consistent error handling
/// for async operations. Handles Dio and generic exceptions.
///
/// Extend this mixin and override [mapException] to add package-specific
/// exception handling (e.g., FirebaseAuthException, FirebaseException).
///
/// Example:
/// ```dart
/// mixin FirebaseExceptionHandler on ExceptionHandler {
///   @override
///   Failure? mapException(Object error) {
///     if (error is FirebaseAuthException) {
///       return AuthFailure(error.message ?? kGenericErrorMessage);
///     }
///     return super.mapException(error);
///   }
/// }
/// ```
mixin ExceptionHandler {
  /// Override this method to map package-specific exceptions to failures.
  /// Return `null` to fall through to default handling.
  Failure? mapException(Object error) => null;

  /// Executes an async operation and wraps the result in a [Result].
  ///
  /// Catches exceptions and maps them to appropriate [Failure] types.
  /// Use [mapException] override for package-specific exception handling.
  FutureResult<T> handleException<R, T>(
    Future<R> execute, {
    required FutureOr<T> Function(R response) onSuccess,
  }) async {
    try {
      final result = await execute;
      return Result.success(await onSuccess(result));
    } on Failure catch (failure) {
      // Re-wrap failures that were thrown (e.g., FirebaseFailure.notLoggedIn())
      return Result.failure(failure);
    } on DioException catch (error) {
      return Result.failure(mapException(error) ?? _mapDioException(error));
    } on FormatException catch (e) {
      return Result.failure(mapException(e) ?? FormatFailure(e.message));
    } on Exception catch (e) {
      return Result.failure(
        mapException(e) ?? const GenericFailure(kGenericErrorMessage),
      );
    }
  }

  Failure _mapDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.badResponse => DioFailure(switch (error.response?.data) {
        {'detail': final String detail} => detail,
        _ => 'Received invalid status code: ${error.response?.statusCode}',
      }),
      DioExceptionType.cancel => const CancellationFailure(
        'Request was canceled.',
      ),
      DioExceptionType.connectionError => const DioFailure(
        'No internet connection. Please check your network and try again.',
      ),
      DioExceptionType.connectionTimeout => const DioFailure(
        'The request timed out. Please check your connection and try again.',
      ),
      DioExceptionType.receiveTimeout => const DioFailure(
        'The server took too long to respond. Please try again.',
      ),
      DioExceptionType.sendTimeout => const DioFailure(
        'The request timed out while sending data. Please try again',
      ),
      DioExceptionType.badCertificate => const DioFailure(
        'A bad certificate was encountered. Please try again.',
      ),
      _ => const DioFailure(kGenericErrorMessage),
    };
  }
}

/// Backward-compatible alias for [ExceptionHandler].
/// Prefer using [ExceptionHandler] for new code.
///
/// @Deprecated('Use ExceptionHandler instead')
typedef ApiResponseHandler = ExceptionHandler;

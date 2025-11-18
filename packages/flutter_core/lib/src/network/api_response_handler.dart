import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_core/src/result/result.dart';

mixin ApiResponseHandler {
  static const _genericErrorMessage =
      'An unexpected error occurred. Please try again.';

  FutureResult<TransformedResult>
  handleApiResponse<RawResponse, TransformedResult>(
    Future<RawResponse> executeApi, {
    required FutureOr<TransformedResult> Function(RawResponse response)
    onSuccess,
  }) async {
    try {
      final result = await executeApi;

      return Result.success(await onSuccess(result));
      // } on AuthorizationException catch (e) {
      //   return Left(_mapAuthException(e));
    } on DioException catch (error) {
      return Result.failure(_mapDioException(error));
    } on FormatException catch (e) {
      return Result.failure(FormatFailure(e.message));
    } on Exception catch (_) {
      return Result.failure(GenericFailure(_genericErrorMessage));
    }
  }

  // Failure _mapAuthException(AuthorizationException exception) {
  //   const requiredSegmentCount = 3;
  //   final segments = exception.description?.split('\n') ?? [];

  //   if (segments.length < requiredSegmentCount) {
  //     return OAuthFailure.rawMessage(exception.error);
  //   }

  //   final errorCode = StringHelper.beforeDelimiter(
  //     segments[0],
  //     Delimiter.colon,
  //   );
  //   final errorMessage = StringHelper.afterDelimiter(
  //     segments[0],
  //     Delimiter.colon,
  //   );
  //   final correlationId = StringHelper.afterDelimiter(
  //     segments[1],
  //     Delimiter.colon,
  //   );
  //   final timestamp = StringHelper.afterDelimiter(segments[2], Delimiter.colon);
  //   final timestampDateTime = DateTime.tryParse(timestamp);

  //   // This is MJ's preference for the error message.
  //   final customMessage = errorCode == 'AADB2C90225'
  //       ? 'The username or password provided in the request is invalid.'
  //       : null;

  //   return OAuthFailure(
  //     customMessage ?? errorMessage,
  //     errorCode,
  //     correlationId,
  //     timestamp: timestampDateTime,
  //   );
  // }

  Failure _mapDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.badResponse => DioFailure(
        error.response?.data?['detail'] ??
            'Received invalid status code: ${error.response?.statusCode}',
      ),
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
      _ => const DioFailure(_genericErrorMessage),
    };
  }
}

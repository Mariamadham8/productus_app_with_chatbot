import 'package:dio/dio.dart';
import 'app_error.dart';

class DioErrorHandler {
  static AppError handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return AppError(
          message: "Connection timeout - check your internet",
          statusCode: 408,
        );

      case DioExceptionType.receiveTimeout:
        return AppError(
          message: "Server took too long to respond",
          statusCode: 408,
        );

      case DioExceptionType.sendTimeout:
        return AppError(
          message: "Request timeout - try again",
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.connectionError:
        return AppError(message: "No internet connection");

      case DioExceptionType.cancel:
        return AppError(message: "Request was cancelled");

      case DioExceptionType.badCertificate:
        return AppError(message: "SSL certificate error");

      default:
        return AppError(message: "Unexpected error: ${e.message}");
    }
  }

  static AppError _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage = e.response?.data?['message'];

    switch (statusCode) {
      case 400:
        return AppError(
          message: serverMessage ?? "Bad request",
          statusCode: 400,
        );
      case 401:
        return AppError(
          message: serverMessage ?? "Unauthorized - please login again",
          statusCode: 401,
        );
      case 403:
        return AppError(
          message: serverMessage ?? "Forbidden - no permission",
          statusCode: 403,
        );
      case 404:
        return AppError(
          message: serverMessage ?? "Resource not found",
          statusCode: 404,
        );
      case 408:
        return AppError(
          message: serverMessage ?? "Request timeout",
          statusCode: 408,
        );
      case 422:
        return AppError(
          message: serverMessage ?? "Invalid data sent",
          statusCode: 422,
        );
      case 429:
        return AppError(
          message: serverMessage ?? "Too many requests - slow down",
          statusCode: 429,
        );

      case 500:
        return AppError(
          message: serverMessage ?? "Internal server error",
          statusCode: 500,
        );
      case 502:
        return AppError(
          message: serverMessage ?? "Bad gateway",
          statusCode: 502,
        );
      case 503:
        return AppError(
          message: serverMessage ?? "Service unavailable",
          statusCode: 503,
        );
      case 504:
        return AppError(
          message: serverMessage ?? "Gateway timeout",
          statusCode: 504,
        );

      default:
        return AppError(
          message: serverMessage ?? "Something went wrong",
          statusCode: statusCode,
        );
    }
  }
}

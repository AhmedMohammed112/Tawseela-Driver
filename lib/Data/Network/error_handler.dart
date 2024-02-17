import 'package:dio/dio.dart';

import '../../Presentation/Resources/string_manager.dart';
import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioException(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECTION_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.REICEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
            code: error.response?.statusCode ?? 0,
            message: error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCELLED.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  BAD_GATEWAY,
  SERVICE_UNAVAILABLE,
  CONNECTION_TIMEOUT,
  DEFAULT,
  CANCELLED,
  NO_INTERNET,
  REICEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_TIMEOUT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
            code: ResponseCode.SUCCESS, message: ResponseMessages.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(
            code: ResponseCode.NO_CONTENT,
            message: ResponseMessages.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessages.BAD_REQUEST);
      case DataSource.UNAUTHORIZED:
        return Failure(
            code: ResponseCode.UNAUTHORIZED,
            message: ResponseMessages.UNAUTHORIZED);
      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponseMessages.FORBIDDEN);
      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND, message: ResponseMessages.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessages.INTERNAL_SERVER_ERROR);
      case DataSource.BAD_GATEWAY:
        return Failure(
            code: ResponseCode.BAD_GATEWAY,
            message: ResponseMessages.BAD_GATEWAY);
      case DataSource.SERVICE_UNAVAILABLE:
        return Failure(
            code: ResponseCode.SERVICE_UNAVAILABLE,
            message: ResponseMessages.SERVICE_UNAVAILABLE);
      case DataSource.CONNECTION_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECTION_TIMEOUT,
            message: ResponseMessages.CONNECTION_TIMEOUT);
      case DataSource.DEFAULT:
        return Failure(
            code: ResponseCode.DEFAULT, message: ResponseMessages.DEFAULT);
      case DataSource.CANCELLED:
        return Failure(
            code: ResponseCode.CANCELLED, message: ResponseMessages.CANCELLED);
      case DataSource.NO_INTERNET:
        return Failure(
            code: ResponseCode.NO_INTERNET,
            message: ResponseMessages.NO_INTERNET);
      case DataSource.REICEVE_TIMEOUT:
        return Failure(
            code: ResponseCode.REICEVE_TIMEOUT,
            message: ResponseMessages.REICEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessages.SEND_TIMEOUT);
      case DataSource.CACHE_TIMEOUT:
        return Failure(
            code: ResponseCode.CACHE_TIMEOUT,
            message: ResponseMessages.CACHE_TIMEOUT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // OK
  static const int NO_CONTENT = 202; // NO CONTENT
  static const int BAD_REQUEST = 400; // BAD REQUEST
  static const int UNAUTHORIZED = 401; // UNAUTHORIZED
  static const int FORBIDDEN = 403; // FORBIDDEN
  static const int NOT_FOUND = 404; // NOT FOUND
  static const int INTERNAL_SERVER_ERROR = 500; // INTERNAL SERVER ERROR
  static const int BAD_GATEWAY = 502; // BAD GATEWAY
  static const int SERVICE_UNAVAILABLE = 503; // SERVICE UNAVAILABLE

  static const int CONNECTION_TIMEOUT = -1; // CONNECTION TIMEOUT
  static const int DEFAULT = -2; // UNKNOWN ERROR
  static const int CANCELLED = -3;
  static const int NO_INTERNET = -4;
  static const int REICEVE_TIMEOUT = -5;
  static const int SEND_TIMEOUT = -6;
  static const int CACHE_TIMEOUT = -7;
}

class ResponseMessages {
  static String SUCCESS = StringsManager.success; // OK
  static String NO_CONTENT = StringsManager.noContent; // NO CONTENT
  static String BAD_REQUEST = StringsManager.badRequest; // BAD REQUEST
  static String UNAUTHORIZED = StringsManager.unauthorized; // UNAUTHORIZED
  static String FORBIDDEN = StringsManager.forbidden; // FORBIDDEN
  static String NOT_FOUND = StringsManager.notFound; // NOT FOUND
  static String INTERNAL_SERVER_ERROR = StringsManager.internalServerError; // INTERNAL SERVER ERROR
  static String SERVICE_UNAVAILABLE = StringsManager.serviceUnavailable; // SERVICE UNAVAILABLE
  static String BAD_GATEWAY = StringsManager.badGateway; // BAD GATEWAY

  static String CONNECTION_TIMEOUT = StringsManager.connectionTimeout; // CONNECTION TIMEOUT
  static String DEFAULT = StringsManager.defaultError; // UNKNOWN ERROR
  static String CANCELLED = StringsManager.cancelled;
  static String NO_INTERNET = StringsManager.noInternet;
  static String REICEVE_TIMEOUT = StringsManager.receiveTimeout;
  static String SEND_TIMEOUT = StringsManager.sendTimeout;
  static String CACHE_TIMEOUT = StringsManager.cacheTimeout;
}
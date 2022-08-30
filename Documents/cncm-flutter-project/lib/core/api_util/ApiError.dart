import 'package:dio/dio.dart';

///Best way to handle Api call exceptions with the
///help of dio DioErrorType enums
class ApiCallException implements Exception {
  ApiCallException(this.message);

  ApiCallException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "something went wrong";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!.statusCode!);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = '';

  ///handles on response to the 400, 404, 500
  /// status code error types
  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'error happen check your input';
      case 404:
        return 'The requested data was not found 😐';
      case 401:
        return 'Incorrect phone or password';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

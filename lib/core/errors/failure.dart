import 'package:dio/dio.dart';

abstract class Failure {
  final String error;

  const Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure(super.error);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with APIServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with APIServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with APIServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Invalid Server Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to APIServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(
            'Ooops there was an error, please try again later');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure('Bad Request: $response');
      case 401:
        return ServerFailure('Unauthorized: $response');
      case 404:
        return ServerFailure('Not Found: $response');
      case 500:
        return ServerFailure('Internal Server Error: $response');
      default:
        return ServerFailure('Unexpected Error: $response');
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              print(error.response!.statusCode);
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                print(error.response!.data['message']);
                errorDescription = error.response!.data["message"];
                break;
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  log(error.response!.data.toString());

                 try{
                   errorDescription = error.response!.data["message"];

                 }catch(e){
                   errorDescription = error.response!.data['data']["message"];
                 }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioErrorType.badCertificate:
              errorDescription = "Bad Certificate with server";
              break;
            case DioErrorType.connectionError:
              errorDescription = "Connection Error with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = error.response?.data["message"]??"Some thing went wrong";
    }
    return errorDescription;
  }
}

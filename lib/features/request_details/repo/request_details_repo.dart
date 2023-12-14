import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class RequestDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RequestDetailsRepo(
      {required this.dioClient, required this.sharedPreferences});

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getRequestDetails({
    required int requestId,
  }) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.requestDetails(
            sharedPreferences.getString(AppStorageKey.role), requestId),
      );
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  updateRequest(
      {required int status, required int id, String? offerPrice}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.updateRequest(
              sharedPreferences.getString(AppStorageKey.role), id),
          queryParameters: {"status": status, "offer_price": offerPrice});
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}

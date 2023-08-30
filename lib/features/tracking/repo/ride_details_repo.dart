import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class RideDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RideDetailsRepo({required this.dioClient, required this.sharedPreferences});

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getRideDetails(id) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.rideDetails(
            sharedPreferences.getString(AppStorageKey.role), id),
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

  Future<Either<ServerFailure, Response>> changeRideStatus(
      {required int id, required int status, int? count}) async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.changeRideStatus(
            sharedPreferences.getString(AppStorageKey.role) ?? "client", id),
        queryParameters: {
          "status": status,
          if (status == 2) "time": count,
        },
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
}

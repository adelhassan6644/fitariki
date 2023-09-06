import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class MyTripsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyTripsRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getMyTrips(type) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.myTrips(
          sharedPreferences.getString(AppStorageKey.role),
          type,
          sharedPreferences.getString(AppStorageKey.userId),
        ),
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

  Future<Either<ServerFailure, Response>> getCurrentTripDetails(id) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.myCurrentTripDetails(
            sharedPreferences.getString(AppStorageKey.role) ?? "client", id),
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

  Future<Either<ServerFailure, Response>> getPreviousTripDetails(id) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.myPreviousTripDetails(
            sharedPreferences.getString(AppStorageKey.role) ?? "client", id),
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/data/api/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class MyRidesRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyRidesRepo({required this.dioClient, required this.sharedPreferences});

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getRides(
      {required DateTime day, required String type}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.dayRides(
              sharedPreferences.getString(AppStorageKey.role),
              type,
              sharedPreferences.getString(AppStorageKey.userId)),
          queryParameters: {
            "day": day.dateFormat(format: "yyyy-MM-dd", lang: "en"),
          });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> cancelRide(id) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.cancelTrip(
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

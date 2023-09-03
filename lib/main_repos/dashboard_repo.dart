import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class DashboardRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  DashboardRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> checkExpiredContracts() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.checkExpiredContracts(
            sharedPreferences.getString(AppStorageKey.role) ?? "client",
            sharedPreferences.getString(AppStorageKey.userId)),
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

  Future<Either<ServerFailure, Response>> sendExpiredContractRate(
      {required int id, required int approve, String? reason}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.sendExpiredContractRate(
              sharedPreferences.getString(AppStorageKey.role) ?? "client", id),
          queryParameters: {
            "${sharedPreferences.getString(AppStorageKey.role) ?? "client"}_approval":
                "$approve",
            if (reason != null)
              "${sharedPreferences.getString(AppStorageKey.role) ?? "client"}_disapproval_reason":
                  reason,
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

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  getRole() {
    return sharedPreferences.getString(AppStorageKey.role);
  }

  getUserId() {
    return sharedPreferences.getString(AppStorageKey.userId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class UserProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  UserProfileRepo({required this.dioClient, required this.sharedPreferences});
  Future<Either<ServerFailure, Response>> getUserProfile(
      {required int userID}) async {
    try {
      String? userType;
      if (sharedPreferences.getString(AppStorageKey.role) == "driver") {
        userType = "client";
      } else {
        userType = "driver";
      }
      Response response = await dioClient.get(
        uri:
        "${sharedPreferences.getString(AppStorageKey.role)}/$userType/${EndPoints.userProfile}/$userID",
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

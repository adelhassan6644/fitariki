import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class AddRequestRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddRequestRepo({required this.dioClient, required this.sharedPreferences});

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  getRole() {
    return sharedPreferences.getString(AppStorageKey.role);
  }

  getUserID() {
    return sharedPreferences.getString(AppStorageKey.userId);
  }

  Future<Either<ServerFailure, Response>> requestOffer(
      {body, id, required bool isSpecialOffer}) async {
    try {
      String type;
      if (isDriver()) {
        type = "client";
      } else {
        type = "driver";
      }

      Response response = await dioClient.post(
        uri: isSpecialOffer
            ? EndPoints.specialOffer(
                sharedPreferences.getString(AppStorageKey.role), type, id)
            : EndPoints.addRequest(
                sharedPreferences.getString(AppStorageKey.role), id),
        data: body,
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

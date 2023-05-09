import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/core/utils/app_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class ProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> updateProfile({required dynamic body}) async {
    try {
      Response response = await dioClient.post(
          uri: "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.updateProfile}/${sharedPreferences.getString(AppStorageKey.userId)}",
          data: body);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getProfile() async {
    try {
      Response response = await dioClient.get(
        uri: "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.getProfile}/1"
            // "${sharedPreferences.getString(AppStorageKey.userId)}",
      );
      //{{base}}api/v1/driver/profile/1
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  getRoleType() {
    if (sharedPreferences.containsKey(AppStorageKey.role)) {
      return sharedPreferences.getString(AppStorageKey.role);
    } else {
      return null;
    }
  }
}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    return sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  Future<String?> saveDeviceToken() async {
    String? deviceToken;

    deviceToken = await FirebaseMessaging.instance.getToken();

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  Future<Either<ServerFailure, Response>> updateProfile(
      {required dynamic body}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.updateProfile(
              sharedPreferences.getString(AppStorageKey.role),
              sharedPreferences.getString(AppStorageKey.userId)),
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
        uri: EndPoints.getProfile(
            sharedPreferences.getString(AppStorageKey.role),
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

  Future<Either<ServerFailure, Response>> getCountries() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.getCountries,
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

  Future<Either<ServerFailure, Response>> getBanks() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.getBanks,
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

  getRoleType() {
    if (sharedPreferences.containsKey(AppStorageKey.role)) {
      return sharedPreferences.getString(AppStorageKey.role);
    } else {
      return null;
    }
  }

  getId() {
    return sharedPreferences.getString(AppStorageKey.userId);
  }

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }
}

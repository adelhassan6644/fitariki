import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  AuthRepo({required this.sharedPreferences, required this.dioClient});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  saveUserRole({required String id, required String type}) {
    sharedPreferences.setString(AppStorageKey.userId, id);
    sharedPreferences.setString(AppStorageKey.role, type);
  }

  getMail() {
    if (sharedPreferences.containsKey(AppStorageKey.mail)) {
      return sharedPreferences.getString(
        AppStorageKey.mail,
      );
    }
  }

  remember(mail) {
    sharedPreferences.setString(AppStorageKey.mail, mail);
  }

  forget() {
    sharedPreferences.remove(AppStorageKey.mail);
  }

  Future<String?> saveDeviceToken() async {
    String? deviceToken;
    if (Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  Future<Either<ServerFailure, Response>> logIn(
      {required String mail,
      required String password,
      required String userType}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.logIn, data: {
        "email": mail,
        "password": password,
        "fcm_token": await saveDeviceToken()
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

  Future<Either<ServerFailure, Response>> reset({
    required String password,
    required String email,
    required String role,
  }) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.resetPassword, data: {
        "email": email,
        "newPassword": password,
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

  Future<Either<ServerFailure, Response>> change(
      {required String oldPassword, required String password}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.changePassword(
              sharedPreferences.getString(AppStorageKey.userId)),
          data: {
            "oldPassword": oldPassword,
            "newPassword": password,
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

  Future<Either<ServerFailure, Response>> forgetPassword(
      {required String mail, required String role}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.forgetPassword, data: {
        "email": mail,
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

  Future<Either<ServerFailure, Response>> register(
      {required String mail, required String role}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.register,
          data: {"email": mail, "fcm_token": await saveDeviceToken()});

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> resendCode(
      {required String mail,
      required String role,
      required bool fromRegister}) async {
    try {
      Response response = await dioClient.post(
          uri: fromRegister ? EndPoints.resend : EndPoints.forgetPassword,
          data: {"email": mail});

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> verifyMail(
      {required String mail,
      required String code,
      required bool fromRegister,
      required String role}) async {
    try {
      Response response = await dioClient.post(
          uri: fromRegister
              ? EndPoints.verifyEmail
              : EndPoints.checkMailForResetPassword,
          data: {"code": code, "email": mail});
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppStorageKey.userId);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }
}

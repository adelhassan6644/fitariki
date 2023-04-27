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


class FirebaseAuthRepo {
  late final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  FirebaseAuthRepo({required this.sharedPreferences,required this.dioClient});


  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  getPhone() {
    if( sharedPreferences.containsKey(AppStorageKey.phone,)) {
      return sharedPreferences.getString(AppStorageKey.phone,);
    }
  }

  remember({required String phone}) {
    sharedPreferences.setString(AppStorageKey.phone, phone);
  }

  forget() {
    sharedPreferences.remove(AppStorageKey.phone);
  }

  Future<String?> getFcmToken() async {
    String? _deviceToken;
    if(Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }else {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (_deviceToken != null) {
      log('--------Device Token---------- $_deviceToken');
    }
    return _deviceToken;
  }


  Future<Either<ServerFailure, Response>> sendDeviceToken({required String phone}) async {
    try {
      Response res = await dioClient.post(
        data: {"fcm_token": await getFcmToken(),"phone":phone},
        uri: EndPoints.logIn,);
      if(res.statusCode ==200){
        saveUserToken(token: res.data['data']["api_token"]);
        return Right(res);
      } else {
    return left(ServerFailure(res.data['message']));
    }
    } catch (error) {
    return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<void> saveUserToken({required String token}) async {
    try {
      dioClient.updateHeader(token: token);
      await sharedPreferences.setString(AppStorageKey.token, token);
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppStorageKey.token);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }


}

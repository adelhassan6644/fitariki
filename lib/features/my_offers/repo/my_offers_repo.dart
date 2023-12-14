import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class MyOffersRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyOffersRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  String? get userId => sharedPreferences.getString(AppStorageKey.userId);
  String? get userRole => sharedPreferences.getString(AppStorageKey.role);

  Future<Either<ServerFailure, Response>> getMyRequests() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.myRequests(userRole, userId),
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

  Future<Either<ServerFailure, Response>> getMyOffers() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.myOffers(userRole, userId),
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

  Future<Either<ServerFailure, Response>> getMyOfferDetails(
      {required int id}) async {
    try {
      Response response = await dioClient.get(
          uri: EndPoints.viewMyOffers(userRole, id),
          queryParameters: {"${userRole ?? "client"}_id": userId});
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> deleteMyOffer(id) async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.deleteOffer(userRole, id),
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

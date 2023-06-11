import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class OfferDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  OfferDetailsRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }
  bool isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getOfferDetails({offerId}) async {
    try {
      Response response = await dioClient.get(
          uri:
              "${sharedPreferences.getString(AppStorageKey.role) ?? "client"}/${EndPoints.offerDetails}/$offerId",
          queryParameters: {
            "${sharedPreferences.getString(AppStorageKey.role) ?? "client"}_id":
                sharedPreferences.getString(AppStorageKey.userId)
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

  Future<Either<ServerFailure, Response>> getOfferFeedback(offerId) async {
    try {
      Response response = await dioClient.get(
        uri: "client/${EndPoints.getOfferFeedback}/$offerId",
      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offer_model.dart';

class PostOfferRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  PostOfferRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> postOffer(
      {required OfferModel offerModel}) async {
    try {
      offerModel.id =
          int.parse(sharedPreferences.getString(AppStorageKey.userId)!);
      Response response = await dioClient.post(
          uri:
              "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.postOffer}",
          data: sharedPreferences.getString(AppStorageKey.role) == "driver"
              ? offerModel.toPostDriverJson()
              : offerModel.toPostClientJson());
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

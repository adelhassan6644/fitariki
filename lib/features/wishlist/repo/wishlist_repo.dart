import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class WishlistRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  WishlistRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Either<ServerFailure, Response>> getWishList() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.getWishList(
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

  Future<Either<ServerFailure, Response>> postWishList(
      {required int id, required bool isOffer}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.postWishList(
              sharedPreferences.getString(AppStorageKey.role),
              sharedPreferences.getString(AppStorageKey.userId)),
          queryParameters: {
           if(isOffer) "offer_id": id,
            if (sharedPreferences.getString(AppStorageKey.role) == "driver" && !isOffer)
              "client_id": id,
            if (sharedPreferences.getString(AppStorageKey.role) == "client" && !isOffer)
              "driver_id": id,
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
}

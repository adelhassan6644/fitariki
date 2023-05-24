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

  Future<Either<ServerFailure, Response>> getWishList() async {
    try {
      Response response = await dioClient.get(
        uri:
            // "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.getWishList}/1",
            "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.getWishList}/${sharedPreferences.getString(AppStorageKey.userId)}",
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
      {int? offerId, int? userId}) async {
    try {
      Response response = await dioClient.post(
          uri:
              // "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.postWishList}/1",
              "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.postWishList}/${sharedPreferences.getString(AppStorageKey.userId)}",
          queryParameters: {
            "offer_id": offerId,
            if (sharedPreferences.getString(AppStorageKey.role) == "driver" &&
                userId != null)
              "client_id": userId,
            if (sharedPreferences.getString(AppStorageKey.role) == "client" &&
                userId != null)
              "driver_id": userId,
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

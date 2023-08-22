import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/config/di.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class UserProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  UserProfileRepo({required this.dioClient, required this.sharedPreferences});

  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> getUserProfile(
      {required int userID}) async {
    try {
      String role;
      if (isDriver()) {
        role = "client";
      } else {
        role = "driver";
      }
      Response response = await dioClient.get(
          uri:
              "${sharedPreferences.getString(AppStorageKey.role) ?? "client"}/$role/${EndPoints.userProfile}/$userID",
          queryParameters: {
            if (sl.get<SharedPreferences>().getString(AppStorageKey.role) !=
                null)
              "${sl.get<SharedPreferences>().getString(AppStorageKey.role)}_id":
                  sl.get<SharedPreferences>().getString(AppStorageKey.userId),
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

  Future<Either<ServerFailure, Response>> getUserOffers(
      {required int id}) async {
    try {
      String role;
      if (isDriver()) {
        role = "client";
      } else {
        role = "driver";
      }
      Response response = await dioClient.get(
        uri: "$role/${EndPoints.myOffers}/$id",
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

  Future<Either<ServerFailure, Response>> getUserFollowers(
      {required int id}) async {
    try {
      Response response = await dioClient.get(
        uri: "client/${EndPoints.followers}/$id",
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

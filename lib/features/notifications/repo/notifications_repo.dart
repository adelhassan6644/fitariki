import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class NotificationsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  NotificationsRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getNotification() async {
    try {
      Response response = await dioClient.get(
        uri:
            "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.notifications}/${sharedPreferences.getString(AppStorageKey.userId)}",
            // "client/${EndPoints.notifications}/29",
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

  Future<Either<ServerFailure, Response>> readNotification(id) async {
    try {
      Response response = await dioClient.post(
        uri:
            "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.readNotification}/${sharedPreferences.getString(AppStorageKey.userId)}/$id}",
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class FeedbackRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FeedbackRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> sendFeedback(
      {required int offerId,
      required int userId,
      required int rating,
      required String feedback}) async {
    try {
      bool isDriver;
      if (sharedPreferences.getString(AppStorageKey.role) == "driver") {
        isDriver = true;
      } else {
        isDriver = false;
      }
      Response response = await dioClient.post(
          uri:
              "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.sendFeedback}/$offerId",
          queryParameters: {
            "rating": rating,
            "feedback": feedback,

            if (!isDriver) "client_id": userId,
            if (isDriver) "driver_id": userId,
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

  Future<Either<ServerFailure, Response>> getFeedback() async {
    try {
      Response response = await dioClient.get(
        uri:
            "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.getFeedback}/${sharedPreferences.getString(AppStorageKey.userId)}",
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

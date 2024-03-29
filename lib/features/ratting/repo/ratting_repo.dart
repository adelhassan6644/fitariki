import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class RattingRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RattingRepo({required this.dioClient, required this.sharedPreferences});

  bool isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> sendRate({
    required int id,
    required int rating,
  }) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.sendRideRate(
              sharedPreferences.getString(AppStorageKey.role)??"client",id),
          queryParameters: {
            "rate": rating,
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class ReportRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ReportRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> sendReport(
      {required int reservationId,
      required int userId,
      required String report}) async {
    try {
      String reportType;
      if (sharedPreferences.getString(AppStorageKey.role) == "driver") {
        reportType = "client";
      }
      else {
        reportType = "driver";
      }
      Response response = await dioClient.post(
          uri: EndPoints.report(sharedPreferences.getString(AppStorageKey.role),
              reportType, userId),
          queryParameters: {
            "comment": report,
            "reservation_id": reservationId,
            "${sharedPreferences.getString(AppStorageKey.role)}_id":
                sharedPreferences.getString(AppStorageKey.userId),
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

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
      bool isDriver;
      String role;
      if (sharedPreferences.getString(AppStorageKey.role) == "driver") {
        isDriver = true;
        role = "client";
      } else {
        isDriver = false;
        role = "driver";
      }
    //   id: 38,
    // created_at: "2023-07-06T16:31:31.000000Z",
    // updated_at: "2023-07-06T16:36:05.000000Z",
    // driver_id: 70,
    // client_id: 54,
    // offer_id: 101,
    // status: 1,
    // paid: 1,
      Response response = await dioClient.post(
          uri:
              "${sharedPreferences.getString(AppStorageKey.role)}/$role/${EndPoints.report}/${userId}",
          queryParameters: {
            "comment": report,
            "reservation_id": reservationId,
            if (!isDriver) "client_id": sharedPreferences.getString(AppStorageKey.userId),
            if (isDriver) "driver_id": sharedPreferences.getString(AppStorageKey.userId),
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

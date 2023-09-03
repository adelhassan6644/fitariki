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

  bool isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  Future<Either<ServerFailure, Response>> sendFeedback(
      {required int offerId,
      required int userId,
      required int rating,
      required String feedback}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.sendFeedback(
            sharedPreferences.getString(AppStorageKey.role),
            offerId,
          ),
          queryParameters: {
            "rating": rating,
            "feedback": feedback,
            "${sharedPreferences.getString(AppStorageKey.role)}_id": userId,
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
        uri: EndPoints.getFeedback(
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

  Future<Either<ServerFailure, Response>> getReviews(id, isOffer) async {
    try {
      String? type;
      if (isDriver()) {
        type = "client";
      } else {
        type = "driver";
      }

      Response response = await dioClient.get(
        uri: isOffer
            ? EndPoints.getOfferFeedback(
                sharedPreferences.getString(AppStorageKey.role), id)
            : EndPoints.getFeedback(type, id),
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

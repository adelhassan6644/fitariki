import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class AddOfferRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddOfferRepo({required this.dioClient,required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> requestOffer({var body, tripID}) async {
    try {
      Response response = await dioClient.post(
        uri:
        "${sharedPreferences.getString(AppStorageKey.role)}/${EndPoints.addOffer}/$tripID",
        data: body,
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
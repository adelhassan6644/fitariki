import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class EditProfileRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  EditProfileRepo({required this.dioClient,required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> editProfile({required Map body}) async {
    try {

      Response response = await dioClient.post(uri: EndPoints.editProfile, data: body);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getProfile() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.editProfile,);
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
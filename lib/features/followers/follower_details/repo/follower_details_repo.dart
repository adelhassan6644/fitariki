import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/dio/dio_client.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';

class FollowerDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FollowerDetailsRepo(
      {required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> updateFollowerDetails(
      {var body, id}) async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.updateFollower(id),
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

  Future<Either<ServerFailure, Response>> deleteFollower(
      {required int id}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.deleteFollower(id));
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

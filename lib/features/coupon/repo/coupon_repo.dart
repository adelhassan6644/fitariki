
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class CouponRepo {
  final DioClient dioClient;
  CouponRepo({required this.dioClient});



  Future<Either<ServerFailure, Response>>  applyCoupon({required String code , required int offer_id}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.couponURl,
      data: {
        'code':code,
        "offer_id":offer_id
      }
      );
      return Right(response);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }
}
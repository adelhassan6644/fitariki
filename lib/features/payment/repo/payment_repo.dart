import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../request_details/model/offer_request_details_model.dart';

class PaymentRepo {
  final DioClient dioClient;
  PaymentRepo({required this.dioClient});

  Future<Either<ServerFailure, Response>> reserveOffer(
      {required OfferRequestDetailsModel requestModel}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.reserve, data: {
        'client_id': requestModel.clientId,
        "driver_id": requestModel.driverId,
        "offer_id": requestModel.offerId,
        "offer_request_id": requestModel.id,
      });
      return Right(response);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<ServerFailure, Response>> applyCoupon(
      {required String code, required int offerId}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.couponURl, data: {'code': code, "offer_id": offerId});
      return Right(response);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../request_details/model/offer_request_details_model.dart';

class PaymentRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  PaymentRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> reserveOffer({
    required OfferRequestDetailsModel requestModel,
    int? coupon,
    required bool useWallet,
  }) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.reserve, data: {
        'client_id': sharedPreferences.getString(AppStorageKey.userId),
        "driver_id":
            requestModel.driverModel?.id ?? requestModel.offer?.driverModel?.id,
        "offer_id": requestModel.offerId,
        "offer_request_id": requestModel.id,
        "use_wallet": useWallet ? 1 : 0
      });
      return Right(response);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<ServerFailure, Response>> reserveFreeOffer(
      {required OfferRequestDetailsModel requestModel,
      int? couponId,
      required int reservationId,
      required bool useWallet,
      required bool isFree}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.freeReserve, data: {
        if (couponId != null) "coupon_id": couponId,
        "use_wallet": useWallet ? 1 : 0,
        "reservation_id": reservationId
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

  Future<Either<ServerFailure, Response>> paymentFees() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.appConfig,
      );
      return Right(response);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }
}

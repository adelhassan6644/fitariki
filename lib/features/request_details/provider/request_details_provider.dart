import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../success/model/success_model.dart';
import '../model/offer_request_details_model.dart';
import '../repo/request_details_repo.dart';

class RequestDetailsProvider extends ChangeNotifier {
  final RequestDetailsRepo requestDetailsRepo;
  RequestDetailsProvider({
    required this.requestDetailsRepo,
  });

  bool get isDriver => requestDetailsRepo.isDriver();

  TextEditingController negotiationPrice = TextEditingController();
  bool isAccepting = false;
  bool isNegotiation = false;
  bool isRejecting = false;

  updateRequest({
    required int status,
    required int id,
    String? name,
  }) async {
    try {
      if (status == 1) {
        isAccepting = true;
      } else if (status == 2) {
        isNegotiation = true;
      } else {
        isRejecting = true;
      }
      notifyListeners();
      final response = await requestDetailsRepo.updateRequest(
          status: status, id: id, offerPrice: negotiationPrice.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        if (status == 2) {
          CustomNavigator.pop();
        }
        isAccepting = false;
        isNegotiation = false;
        isRejecting = false;
        notifyListeners();
      }, (response) {
        if (status == 1) {
          isAccepting = false;
          if (!isDriver) {
            CustomNavigator.push(
              Routes.PAYMENT,
              replace: true,
            );
          } else {
            CustomNavigator.push(Routes.SUCCESS,
                replace: true,
                arguments: SuccessModel(
                    routeName: Routes.DASHBOARD,
                    argument: 1,
                    isClean: true,
                    term: name,
                    btnText: getTranslated("my_trips",
                        CustomNavigator.navigatorState.currentContext!),
                    description: "تم قبول عرض من $name بإنتظار الدفع ..."));
          }
        } else if (status == 2) {
          isNegotiation = false;
          negotiationPrice.clear();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("new_offer_price_sent",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: ColorResources.ACTIVE,
                  borderColor: Colors.transparent));
        } else {
          isRejecting = false;
          CustomNavigator.pop();
        }
        notifyListeners();
      });
    } catch (e) {
      if (status == 2) {
        CustomNavigator.pop();
      }
      isAccepting = false;
      isNegotiation = false;
      isRejecting = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  bool isLoading = false;
  OfferRequestDetailsModel? requestModel;
  getRequestDetails({
    required int id,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await requestDetailsRepo.getRequestDetails(requestId: id);
      response.fold((l) => null, (res) {
        if (res.data["data"]["request"] != null) {
          requestModel =
              OfferRequestDetailsModel.fromJson(res.data["data"]["request"]);
        }
        Provider.of<PaymentProvider>(
                CustomNavigator.navigatorState.currentContext!,
                listen: false)
            .setData(requestModel);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}

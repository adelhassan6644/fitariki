import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../profile/provider/profile_provider.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../../success/model/success_model.dart';
import '../model/coupon_model.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../repo/payment_repo.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentRepo paymentRepo;

  PaymentProvider({required this.paymentRepo}) {
    paymentFees();
  }

  bool useWallet = false;
  void onUseWallet(v) {
    useWallet = v;
    calcTotal();
    notifyListeners();
  }

  OfferRequestDetailsModel? requestModel;
  setData(data) {
    requestModel = data;
    calcTotal();
    notifyListeners();
  }

  CouponModel? _coupon;
  double _discount = 0.0;
  String _code = '';
  double? tax;
  double taxPercentage = 0.0;
  double serviceCost = 0;
  double servicePercentage = 0;
  double wallet = sl.get<ProfileProvider>().profileModel?.client?.wallet ?? 0.0;
  double total = 0.0;
  bool _isLoading = false;
  bool isPaymentFeeLoading = false;

  CouponModel? get coupon => _coupon;

  double get discount => _discount;

  String get code => _code;

  bool get isLoading => _isLoading;
  TextEditingController discountCode = TextEditingController();

  int currentPayment = 0;

  onSelectPayment(index) {
    currentPayment = index;
    notifyListeners();
  }

  Future<double> applyCoupon({
    required String coupon,
  }) async {
    _isLoading = true;
    notifyListeners();
    double price = requestModel!.price!;
    var apiResponse =
        await paymentRepo.applyCoupon(offerId: requestModel!.id!, code: coupon);
    apiResponse.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      _coupon = CouponModel.fromJson(success.data['data']['coupon']);
      _code = _coupon!.code;
      if (_coupon!.type == 'presntage') {
        if (_coupon!.max != 0) {
          _discount = ((_coupon!.amount * price / 100) < _coupon!.max!
              ? (_coupon!.amount * price / 100)
              : _coupon!.max)!;
        } else {
          _discount = _coupon!.amount * price / 100;
        }
      } else {
        _discount = _coupon!.amount;
      }
      calcTotal();
    });

    _isLoading = false;
    notifyListeners();
    return _discount;
  }

  void removeCouponData(bool notify) {
    _coupon = null;
    _isLoading = false;
    _discount = 0.0;
    _code = '';
    calcTotal();
    discountCode = TextEditingController();
    if (notify) {
      notifyListeners();
    }
  }

  Future<double> paymentFees() async {
    isPaymentFeeLoading = true;
    notifyListeners();

    var apiResponse = await paymentRepo.paymentFees();
    apiResponse.fold((fail) {
      isPaymentFeeLoading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      taxPercentage =
          double.parse(success.data['data']['settings'][0]['tax'].toString());
      servicePercentage = double.parse(
          success.data['data']['settings'][0]['service_fee'].toString());

      calcTotal();
      isPaymentFeeLoading = false;
      notifyListeners();
    });

    return _discount;
  }

  calcTotal() {
    tax = 0;
    serviceCost = 0;
    total = 0;
    tax = double.parse(
        ((requestModel?.price ?? 0) * taxPercentage / 100).toStringAsFixed(2));
    serviceCost = double.parse(
        ((requestModel?.price ?? 0) * servicePercentage / 100)
            .toStringAsFixed(2));

    total = requestModel!.price! +
        tax! +
        serviceCost -
        _discount -
        (useWallet ? wallet : 0);

    if (total < 0) {
      total = 0;
    }
    notifyListeners();
  }

  ///checkout & payment
  bool isCheckOut = false;
  checkOut() async {
    try {
      isCheckOut = true;
      notifyListeners();
      var apiResponse;
      //is free

      apiResponse = await paymentRepo.reserveOffer(
          requestModel: requestModel!,
          coupon: _coupon!.id,
          useWallet: useWallet);

      apiResponse!.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) async {
        if (success.data["resID"] != null) {
          if (total != 0) {
            CustomNavigator.push(Routes.PAYMENTWEBVIEW,
                arguments: success.data["resID"]);
          } else {
            await payFreeOffer(reservationId: success.data["resID"]);
          }
        } else {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated(
                      "fail", CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }
      });

      isCheckOut = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isCheckOut = false;
      notifyListeners();
    }
  }

  payFreeOffer({required int reservationId}) async {
    try {
      var apiResponse = await paymentRepo.reserveFreeOffer(
          requestModel: requestModel!,
          couponId: _coupon!.id,
          isFree: total == 0,
          useWallet: useWallet,
          reservationId: reservationId);

      apiResponse.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        CustomNavigator.push(Routes.SUCCESS,
            replace: true,
            arguments: SuccessModel(
                isPopUp: true,
                title: getTranslated("congratulations",
                    CustomNavigator.navigatorState.currentContext!),
                onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                    arguments: 0, clean: true),
                term: sl<RequestDetailsProvider>()
                        .requestModel
                        ?.driverModel
                        ?.firstName
                        ?.split(" ")[0] ??
                    sl<RequestDetailsProvider>()
                        .requestModel
                        ?.offer
                        ?.driverModel
                        ?.firstName
                        ?.split(" ")[0] ??
                    "",
                description:
                    "${getTranslated("trip_was_successfully_paid_for_captain", CustomNavigator.navigatorState.currentContext!)} ${sl<RequestDetailsProvider>().requestModel?.driverModel?.firstName?.split(" ")[0] ?? sl<RequestDetailsProvider>().requestModel?.offer?.driverModel?.firstName?.split(" ")[0] ?? ""}"));
      });

      isCheckOut = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isCheckOut = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../model/coupon_model.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../repo/payment_repo.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentRepo paymentRepo;

  PaymentProvider({required this.paymentRepo}){paymentFees(); }

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
  double taxPercentage=0.0;
  double serviceCost = 0;
  double servicePercentage = 0;
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
    double amount = requestModel!.price!;
    var apiResponse =
        await paymentRepo.applyCoupon(offerId: requestModel!.id!, code: coupon);
    apiResponse.fold((fail) {
      _isLoading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      _coupon = CouponModel.fromJson(success.data['data']['coupon']);
      _code = _coupon!.code;
      if (_coupon!.type == 'presntage') {
        if (_coupon!.max != 0) {
          _discount = ((_coupon!.amount * amount / 100) < _coupon!.max!
              ? (_coupon!.amount * amount / 100)
              : _coupon!.max)!;
        } else {
          _discount = _coupon!.amount * amount / 100;
        }
      } else {
        _discount = _coupon!.amount;
      }
      calcTotal();
      _isLoading = false;
      notifyListeners();
    });

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
  Future<double> paymentFees() async
  {
    isPaymentFeeLoading = true;
    notifyListeners();

    var apiResponse =
    await paymentRepo.paymentFees();
    apiResponse.fold((fail) {
      isPaymentFeeLoading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      taxPercentage=double.parse(success.data['data']['settings'][0]['tax'].toString());
      servicePercentage=double.parse(success.data['data']['settings'][0]['service_fee'].toString());

      calcTotal();
      isPaymentFeeLoading = false;
      notifyListeners();
    });

    return _discount;
  }
  calcTotal() {
    tax=0;
    serviceCost=0;
    total=0;
    tax = double.parse(((requestModel?.price ?? 0) * taxPercentage/100).toStringAsFixed(2));
    serviceCost = double.parse(((requestModel?.price ?? 0) * servicePercentage/100).toStringAsFixed(2));
    print(serviceCost);
    total = (requestModel!.price! - _discount) + tax! + serviceCost;
    print((requestModel!.price! - _discount) + tax!  );
    notifyListeners();
  }

  ///checkout & payment
  bool isCheckOut = false;
  checkOut() async {
    try {
      isCheckOut = true;
      notifyListeners();

      var apiResponse =
          await paymentRepo.reserveOffer(requestModel: requestModel!);
      apiResponse.fold((fail) {
        isCheckOut = false;
        notifyListeners();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["resID"] != null) {
          CustomNavigator.push(Routes.PAYMENTWEBVIEW,
              arguments: success.data["resID"]);
        } else {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated(
                      "fail", CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }
        isCheckOut = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isCheckOut = false;
      notifyListeners();
    }
  }
}

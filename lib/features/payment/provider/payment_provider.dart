import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../coupon/models/coupon_model.dart';
import '../../coupon/repo/coupon_repo.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../page/payment_webView_screen.dart';
import '../repo/payment_repo.dart';

class PaymentProvider extends ChangeNotifier {
  final CouponRepo couponRepo;
  final PaymentRepo paymentRepo;

  PaymentProvider({required this.couponRepo,required this.paymentRepo}){ calcTotal();}

  CouponModel? _coupon;
  double _discount = 0.0;
  String _code = '';
  double offerPrice = sl.get<RequestDetailsProvider>().requestModel!.price!;
  double tax = 0.0;
  double serviceCost = 15;
  double total = 0.0;
  bool _isLoading = false;

  CouponModel? get coupon => _coupon;

  double get discount => _discount;

  String get code => _code;

  bool get isLoading => _isLoading;
  TextEditingController discountCode = TextEditingController();
  OfferRequestDetailsModel? requestModel =
      sl.get<RequestDetailsProvider>().requestModel;
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
        await couponRepo.applyCoupon(offer_id: requestModel!.id!, code: coupon);
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

  calcTotal() {
    tax = (offerPrice*(tax/100));
    total = (offerPrice - discount) + tax+ serviceCost;
    notifyListeners();
  }

  ///checkout & payment

  checkOut() async {
    var apiResponse =
        await paymentRepo.reserveOffer(requestModel: requestModel!);
    apiResponse.fold((fail) {
      _isLoading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (succes) {
      if (succes.data["resID"] != null) {

        CustomNavigator.push(Routes.PAYMENTWEBVIEW,
            replace: true,
            arguments: succes.data["resID"]);

      } else {
        // showCustomSnackBar(message: succes.data["message"], context: context);
      }

    });
  }


}

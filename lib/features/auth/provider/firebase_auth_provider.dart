import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/firebase_auth_repo.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuthRepo firebaseAuthRepo;
  FirebaseAuthProvider({
    required this.firebaseAuthRepo,
  }) {
    _phoneTEC = TextEditingController(
        text: kDebugMode ? "555666777" : firebaseAuthRepo.getPhone());
  }

  late final TextEditingController _phoneTEC;
  TextEditingController get phoneTEC => _phoneTEC;

  String? firebaseVerificationId;

  bool _isRememberMe = false;
  bool get isRememberMe => _isRememberMe;
  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  String countryPhoneCode = "+966";
  String countryCode = "SA";
  void onSelectCountry({required String code, required String phone}) {
    countryPhoneCode = "$phone+";
    countryCode = code;
    notifyListeners();
  }

  int _userType = 0;
  int get userType => _userType;
  List<String> usersTypes = ["passenger", "captain"];
  List<String> role = ["client", "driver"];
  void selectedUserType(int value) {
    _userType = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSubmit = false;
  bool get isSubmit => _isSubmit;

  bool get isLogin => firebaseAuthRepo.isLoggedIn();
  String smsCode = "";

  void updateVerificationCode(String code) {
    smsCode = code;
    notifyListeners();
  }

  signInWithMobileNo() async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$countryPhoneCode${_phoneTEC.text.trim()}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (authCredential) =>
            phoneVerificationCompleted(authCredential),
        verificationFailed: (authException) =>
            phoneVerificationFailed(authException),
        codeSent: (verificationId, code) =>
            phoneCodeSent(verificationId: verificationId, code: code ?? 0),
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      _isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }

  phoneVerificationCompleted(AuthCredential authCredential) {
    log("====>phoneVerificationCompleted ${authCredential.token}");
  }

  phoneVerificationFailed(FirebaseException authException) {
    if (authException.code == 'invalid-phone-number') {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "رقم الهاتف غير صحيح",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    } else {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: authException.message.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
    _isLoading = false;
    notifyListeners();
  }

  phoneCodeAutoRetrievalTimeout(String verificationCode) {
    log("====>phoneCodeAutoRetrievalTimeout is $firebaseVerificationId");
    firebaseVerificationId = verificationCode;
    notifyListeners();
  }

  phoneCodeSent({required String verificationId, required int code,}) async {
    _isLoading = false;
    firebaseVerificationId = verificationId;
    CustomNavigator.pop();
    CustomNavigator.push(Routes.VERIFICATION,);
    notifyListeners();
  }

  sendOTP({required String code}) async {
    _isSubmit = true;
    notifyListeners();
    try {
      if (firebaseVerificationId != null) {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId!,
          smsCode: code,
        );
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          ///  to send Device token
          await userLogin();

          _isSubmit = false;
          notifyListeners();
        }).catchError((error) {
          _isSubmit = false;
          log(error.toString());
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "الكود غير صحيح",
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          notifyListeners();
        });
      } else {
        log("====>has error in firebaseVerificationId $firebaseVerificationId");
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "has error in firebaseVerificationId",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }
      _isSubmit = false;
      notifyListeners();
    } catch (e) {
      log("====>$e");
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isSubmit = false;
      notifyListeners();
    }
  }

  userLogin() async {
    try {
      Either<ServerFailure, Response> res =
          await firebaseAuthRepo.sendDeviceToken(phone: "+966${_phoneTEC.text.trim()}", role: role[_userType]);
      res.fold((fail) {
        log(ApiErrorHandler.getMessage(fail));
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        firebaseAuthRepo.setLoggedIn();
        firebaseAuthRepo.saveUserToken(token: success.data['data'][role[_userType]]["id"].toString());
        firebaseAuthRepo.remember(phone: "+966${_phoneTEC.text.trim()}");
        if (success.data['data'][role[_userType]]["new_user"] == 1) {
          CustomNavigator.push(Routes.EDIT_PROFILE, replace: true, arguments: true);
        } else {
          CustomNavigator.pop();
        }
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "تم تسجيل الدخول بنجاح",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
      });
    } catch (e) {
      log(e.toString());
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }

  logOut() async {
    try {
      Future.delayed(Duration.zero, () async {
        await FirebaseAuth.instance.signOut();
        await firebaseAuthRepo.clearSharedData();
      });
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("your_logged_out_successfully",
                  CustomNavigator.navigatorState.currentContext!),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}

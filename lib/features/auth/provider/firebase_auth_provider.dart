import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/api_error_handler.dart';
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
  String smsCode = "";
  // String? phone;


  bool _isRememberMe = false;
  bool isLoginBefore = false;
  bool get isRememberMe => _isRememberMe;
  bool _isAgree = true;
  bool get isAgree => _isAgree;

  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool isSubmit = false;
  bool get isLoading => _isLoading;

  bool get isLogin => firebaseAuthRepo.isLoggedIn();

  void updateVerificationCode(String code) {
    smsCode = code;
    notifyListeners();
  }

  signInWithMobileNo() async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+966${_phoneTEC.text.trim()}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (authCredential) => phoneVerificationCompleted(authCredential),
        verificationFailed: (authException) =>
            phoneVerificationFailed(authException),
        codeSent: (verificationId, code) => phoneCodeSent(verificationId: verificationId, code: code ?? 0),
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
    CustomNavigator.push(Routes.VERIFICATION,);
    notifyListeners();
  }

  sendOTP() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (firebaseVerificationId != null) {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId!, smsCode: smsCode.toString().trim(),);
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) {
          ///  to send Device token
          firebaseAuthRepo.sendDeviceToken(phone:"+966${_phoneTEC.text.trim()}" );
          CustomNavigator.push(Routes.DASHBOARD, clean: true,);
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "تم تسجيل الدخول بنجاح",
                  isFloating: true,
                  backgroundColor: ColorResources.ACTIVE,
                  borderColor: Colors.transparent));
          firebaseAuthRepo.setLoggedIn();
          _isLoading = false;
          notifyListeners();
        }).catchError((error) {
          _isLoading = false;
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

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log("====>$e");
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }

  logOut() async {
    try {

      Future.delayed(Duration.zero,() async {

      await FirebaseAuth.instance.signOut();

      await firebaseAuthRepo.clearSharedData();

      // CustomNavigator.push(Routes.LOGIN, clean: true,);
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

  // getUserData(){
  //   phone= FirebaseAuth.instance.currentUser?.phoneNumber;
  //   notifyListeners();
  // }
}

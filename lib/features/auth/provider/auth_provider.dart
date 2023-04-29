import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/auth_repo.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo,}){
    _phoneTEC = TextEditingController(text:kDebugMode ? "597834528" : authRepo.getPhone());
  }

  String? phone;
  late final TextEditingController _phoneTEC;
  TextEditingController get phoneTEC => _phoneTEC;

  String _verificationCode = "";
  String _token = "";
  String get verificationCode => _verificationCode;
  String get token => _token;

  bool _isRememberMe = false;
  bool isLoginBefore = false;
  bool get isRememberMe => _isRememberMe;
   int _userType = 0;
  int get userType => _userType;
  List<String> usersTypes = ["passenger", "captain"];
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

  void selectedUserType(int value) {
    _userType = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool _isSubmit = false;
  bool isError = false;
  bool isErrorOnSubmit = false;
  bool get isLoading => _isLoading;
  bool get isSubmit => _isSubmit;

  bool get isLogin => authRepo.isLoggedIn();

  logIn() async {
    try {
        isError = false;
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response = await authRepo.logIn(phone: "966${_phoneTEC.text.trim()}",);
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          isError = true;
          notifyListeners();
        }, (success) {
          if(_isRememberMe){
            authRepo.remember(phone:_phoneTEC.text.trim());
          }else{
            authRepo.forget();
          }
          _token=success.data['data']["api_token"];
          // isLoginBefore=success.data['is_login_before'] ==0?true:false;
          CustomNavigator.push(
            Routes.VERIFICATION,);
        });
        _isLoading = false;
        notifyListeners();

    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));

      isError = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  verifyPhone() async {
    try {
      isErrorOnSubmit = false;
      _isSubmit = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.verifyPhone(
        phone: "966${_phoneTEC.text.trim()}",
        code: _verificationCode,
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isErrorOnSubmit = true;
        notifyListeners();
      }, (success) {
        authRepo.saveUserToken(token:_token);
        authRepo.setLoggedIn();
        _verificationCode = "";
        if(isLoginBefore){
          CustomNavigator.push(Routes.DASHBOARD, replace: true);
        }else{

        }
      });
      _isSubmit = false;
      notifyListeners();
    } catch (e) {
      isErrorOnSubmit = true;
      _isSubmit = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  void updateVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  logOut() async {
    // CustomNavigator.push(Routes.LOGIN, clean: true);
    await authRepo.clearSharedData();
    CustomSnackBar.showSnackBar(
        notification: AppNotification(
            message: getTranslated("your_logged_out_successfully", CustomNavigator.navigatorState.currentContext!),
            isFloating: true,
            backgroundColor: ColorResources.ACTIVE,
            borderColor: Colors.transparent));
    notifyListeners();
  }
}

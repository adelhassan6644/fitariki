import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../home/provider/home_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../../success/model/success_model.dart';
import '../../wishlist/provider/wishlist_provider.dart';
import '../pages/login.dart';
import '../repo/auth_repo.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/localization/localization/language_constant.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});

  bool get isLogin => authRepo.isLoggedIn();

  final TextEditingController mailTEC = TextEditingController();
  final TextEditingController currentPasswordTEC = TextEditingController();
  final TextEditingController newPasswordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();
  final TextEditingController codeTEC = TextEditingController();

  clear() {
    mailTEC.clear();
    currentPasswordTEC.clear();
    newPasswordTEC.clear();
    confirmPasswordTEC.clear();
    codeTEC.clear();
  }

  bool _isRememberMe = true;
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
  logIn() async {
    try {
      _isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.logIn(
          mail: mailTEC.text.trim(),
          password: newPasswordTEC.text.trim(),
          role: role[_userType]);
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("invalid_credentials",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (_isRememberMe) {
          authRepo.remember(mailTEC.text.trim());
        } else {
          authRepo.forget();
        }
        CustomNavigator.pop();

        authRepo.saveUserRole(
            type: role[_userType],
            id: success.data['data'][role[_userType]]["id"].toString());

        if (success.data['data'][role[_userType]]["email_verified_at"] ==
                null ||
            success.data['data'][role[_userType]]["email_verified_at"] == "") {
          CustomNavigator.push(Routes.VERIFICATION, arguments: true);
        }
        // else if (success.data['data'][role[_userType]]["password"] == null ||
        //     success.data['data'][role[_userType]]["password"] == "") {
        //   CustomNavigator.push(Routes.RESET_PASSWORD, arguments: true);
        // }
        else if (success.data['data'][role[_userType]]["first_name"] ==
                null ||
            success.data['data'][role[_userType]]["first_name"] == "") {
          CustomNavigator.push(Routes.EDIT_PROFILE,
              clean: true, arguments: true);
        } else {
          clear();
          authRepo.setLoggedIn();
        }
      });
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _isReset = false;
  bool get isReset => _isReset;
  resetPassword(bool fromRegister) async {
    try {
      _isReset = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.reset(
          role: role[_userType],
          password: newPasswordTEC.text.trim(),
          email: mailTEC.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (fromRegister) {
          CustomNavigator.push(Routes.EDIT_PROFILE,
              clean: true, arguments: true);
        } else {
          CustomNavigator.push(Routes.SUCCESS,
              clean: true,
              arguments: SuccessModel(
                  onTap: () {
                    CustomNavigator.push(Routes.DASHBOARD,
                        arguments: 0, clean: true);
                    customShowModelBottomSheet(body: const Login());
                  },
                  title: getTranslated("password_updated",
                      CustomNavigator.navigatorState.currentContext!),
                  btnText: getTranslated(
                      "login", CustomNavigator.navigatorState.currentContext!),
                  term: mailTEC.text.trim(),
                  description:
                      "${getTranslated("your_password_has_been_reset_successfully", CustomNavigator.navigatorState.currentContext!)} ${mailTEC.text.trim()}"));
        }
        clear();
      });
      _isReset = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isReset = false;
      notifyListeners();
    }
  }

  bool _isChange = false;
  bool get isChange => _isChange;
  changePassword() async {
    try {
      _isChange = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.change(
          oldPassword: currentPasswordTEC.text.trim(),
          password: newPasswordTEC.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("your_password_changed_successfully",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
        clear();
        notifyListeners();
      });
      _isChange = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isChange = false;
      notifyListeners();
    }
  }

  bool _isRegister = false;
  bool get isRegister => _isRegister;

  register() async {
    try {
      _isRegister = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.register(
        mail: mailTEC.text.trim(),
        role: role[_userType],
      );
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        authRepo.saveUserRole(
            type: role[_userType],
            id: success.data['data'][role[_userType]]["id"].toString());
        CustomNavigator.pop();
        CustomNavigator.push(Routes.VERIFICATION, arguments: true);
      });
      _isRegister = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isRegister = false;
      notifyListeners();
    }
  }

  resend(fromRegister) async {
    await authRepo.resendCode(
      mail: mailTEC.text.trim(),
      role: role[_userType],
      fromRegister: fromRegister,
    );
  }

  bool _isForget = false;
  bool get isForget => _isForget;
  forgetPassword() async {
    try {
      _isForget = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.forgetPassword(
        mail: mailTEC.text.trim(),
        role: role[_userType],
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        CustomNavigator.push(Routes.VERIFICATION,
            replace: true, arguments: false);
      });
      _isForget = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isForget = false;
      notifyListeners();
    }
  }

  bool _isVerify = false;
  bool get isVerify => _isVerify;
  verify(fromRegister) async {
    try {
      spinKitDialog();
      _isVerify = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.verifyMail(
          mail: mailTEC.text.trim(),
          code: codeTEC.text.trim(),
          role: role[_userType],
          fromRegister: fromRegister);
      CustomNavigator.pop();
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        CustomNavigator.push(Routes.RESET_PASSWORD,
            arguments: fromRegister, clean: true);
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("verified_successfully",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      });

      _isVerify = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isVerify = false;
      notifyListeners();
    }
  }

  logOut() async {
    try {
      clear();
      Future.delayed(Duration.zero, () async {
        await authRepo.clearSharedData();
        sl<WishlistProvider>().wishListOfferId.clear();
        sl<ProfileProvider>().clear();
        sl<HomeProvider>().onSelectRole(0);
      });
      CustomNavigator.push(Routes.SPLASH, clean: true);
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}

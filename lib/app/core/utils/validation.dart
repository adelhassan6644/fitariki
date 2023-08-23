import 'package:fitariki/navigation/custom_navigation.dart';
import '../../localization/localization/language_constant.dart';

class Validations {
  static String? name(String? value) {
    if (value!.isEmpty) {
      return getTranslated(
          "required", CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? mail(String? email) {
    if (email!.length < 8 || !email.contains("@") || !email.contains(".com")) {
      return getTranslated("please_enter_valid_email",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? phone(String? value, String? country) {
    if (value!.length < 8) {
      return getTranslated("please_enter_valid_number",
          CustomNavigator.navigatorState.currentContext!);
    } else if (country?.trim() == "SA" &&
        (value[0] != "5" && value[0] != "0")) {
      return getTranslated("please_enter_valid_number",
          CustomNavigator.navigatorState.currentContext!);
    }
    return null;
  }

  static String? bankAccount(String? value) {
    if (value!.isEmpty || value.length < 22) {
      return getTranslated("please_enter_valid_bank_account",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? code(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return getTranslated("please_enter_valid_code",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? city(Object? value) {
    if (value!.toString().isEmpty) {
      return getTranslated(
          "please_choose_city", CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? password(String? password) {
    if (password!.length < 8) {
      return getTranslated("please_enter_valid_password",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? firstPassword(String? password) {
    if (password == null || password.isEmpty) {
      return getTranslated("please_enter_valid_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? newPassword(String? currentPassword, String? newPassword) {
    if (newPassword == null || newPassword.isEmpty) {
      return getTranslated("please_enter_valid_new_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (newPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (currentPassword != null) {
      if (currentPassword == newPassword) {
        return getTranslated("new_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? confirmNewPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_new_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? negotiation(String? value, double maxPrice, double minPrice) {
    if (value!.isEmpty) {
      return "لا يمكن ان تكون فارغة";
    } else if (double.parse(value.toString()) > maxPrice) {
      return "لا يجب ان يكون السعر الجديد اعلي من $maxPrice";
    } else if (double.parse(value.toString()) < minPrice) {
      return "لا يجب ان يكون السعر الجديد اقل من $minPrice";
    } else {
      return null;
    }
  }
}

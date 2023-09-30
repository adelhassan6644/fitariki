import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation/custom_navigation.dart';

abstract class CupertinoPopUpHelper {
  static showCupertinoTextController(
      {required TextEditingController controller,
      required String title,
      required String description,
      required String hint,
      String? sendText,
      String? cancelText,
      TextInputType? keyboardType,
      int? maxLength,
      List<TextInputFormatter>? inputFormatters,
      Function()? onSend,
      Function()? onCancel,
      Function()? onClose}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(backgroundColor: Styles.FILL_COLOR)
          ),
          child: CupertinoAlertDialog(

            title: Center(child: Text(title)),
            content: Column(
              children: [
                Text(
                  description,
                  style: AppTextStyles.w400.copyWith(fontSize: 13,color: Colors.black),
                ),
                CupertinoTextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  maxLength: maxLength,
                  placeholder: hint,
                  placeholderStyle: AppTextStyles.w400.copyWith(fontSize: 16,color:Styles.DETAILS_COLOR) ,
                  decoration: BoxDecoration(
                      color: const Color(0xFF767680).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel();
                    } else {
                      CustomNavigator.pop();
                    }
                  },
                  child: Text(
                    cancelText ??
                        getTranslated("cancel",
                            CustomNavigator.navigatorState.currentContext!),
                    style: AppTextStyles.w400
                        .copyWith(fontSize: 17, color: Styles.SYSTEM_COLOR),
                  )),
              CupertinoDialogAction(
                  onPressed: onSend,
                  child: Text(
                    sendText ??
                        getTranslated("send",
                            CustomNavigator.navigatorState.currentContext!),
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 17, color: Styles.SYSTEM_COLOR),
                  )),
            ],
          ),
        );
      },
    ).then((value) => onClose?.call());
  }

  static showCupertinoPopUp(
      {required String title,
      required String description,
      String? textButton,
      Function()? onConfirm,
      Function()? onClose}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text(title)),
          content: Text(
            description,
            style: AppTextStyles.w400.copyWith(fontSize: 13),
          ),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  if (onClose != null) {
                    onClose();
                  } else {
                    CustomNavigator.pop();
                  }
                },
                child: Text(
                  getTranslated(
                      "cancel", CustomNavigator.navigatorState.currentContext!),
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 17, color: Styles.SYSTEM_COLOR),
                )),
            CupertinoDialogAction(
                onPressed: onConfirm,
                child: Text(
                  textButton ??
                      getTranslated("send",
                          CustomNavigator.navigatorState.currentContext!),
                  style: AppTextStyles.w600
                      .copyWith(fontSize: 17, color: Styles.SYSTEM_COLOR),
                )),
          ],
        );
      },
    ).then((value) => onClose);
  }

  static showWaletCupertinoPopUp(
      {required String title,
      required String description,
      String? textButton,
      Function()? onConfirm,
      Function()? onClose}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text(title)),
          content: Text(
            description,
            style: AppTextStyles.w400.copyWith(fontSize: 13),
          ),
          actions: [
            CupertinoDialogAction(
                onPressed: onConfirm,
                child: Text(
                  textButton ??
                      getTranslated("send",
                          CustomNavigator.navigatorState.currentContext!),
                  style: AppTextStyles.w600
                      .copyWith(fontSize: 16, color: Styles.SYSTEM_COLOR),
                )),
          ],
        );
      },
    ).then((value) => onClose);
  }
}

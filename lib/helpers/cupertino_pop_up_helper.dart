import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation/custom_navigation.dart';

abstract class CupertinoPopUpHelper {
  static showCupertinoTextController(
      {required TextEditingController controller,
      required String title,
      required String description,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      Function()? onSend,
      Function()? onClose}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text(title)),
          content: Column(
            children: [
              Text(
                description,
                style: AppTextStyles.w400.copyWith(fontSize: 13),
              ),
              CupertinoTextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: BoxDecoration(
                    color: const Color(0xFF767680).withOpacity(.12),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  if (onClose != null) {
                    onClose();
                  }
                  CustomNavigator.pop();
                },
                child: Text(
                  'الغاء',
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 17, color: ColorResources.SYSTEM_COLOR),
                )),
            CupertinoDialogAction(
                onPressed: onSend,
                child: Text(
                  'ارسال',
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 17, color: ColorResources.SYSTEM_COLOR),
                )),
          ],
        );
      },
    ).then((value) => onClose);
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navigation/custom_navigation.dart';

abstract class CupertinoPopUpHelper {
  static showCupertinoTextController(
      {required TextEditingController controller}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Center(child: Text('تفاوض')),
          content: Column(
            children: [
              Text(
                "نمكنك من التفاوض مع الطرف الاخر بتحديد سعر جديد",
                style: AppTextStyles.w400.copyWith(fontSize: 13),
              ),
              CupertinoTextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                    color: const Color(0xFF767680).withOpacity(.12),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
                child: Text(
                  'الغاء',
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 17, color: ColorResources.SYSTEM_COLOR),
                ),
                onPressed: () {}),
            CupertinoDialogAction(
                child: Text(
                  'ارسال',
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 17, color: ColorResources.SYSTEM_COLOR),
                ),
                onPressed: () {}),
          ],
        );
      },
    );
  }
}

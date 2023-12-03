import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';

class EmergencyBottomSheet extends StatelessWidget {
  const EmergencyBottomSheet({super.key, this.onFinish});
  final Function()? onFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              getTranslated("emergency", context),
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              getTranslated("emergency_header", context),
              style: AppTextStyles.w400
                  .copyWith(fontSize: 14, color: Styles.DISABLED),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 1,
              width: context.width,
              color: Styles.LIGHT_GREY_BORDER,
              child: const SizedBox(),
            ),
          ),
          InkWell(
            onTap: () async {
              CustomNavigator.pop();
              Future.delayed(
                Duration.zero,
                () => CupertinoPopUpHelper.showCupertinoPopUp(
                    confirmTextButton: getTranslated("call", context),
                    onConfirm: () async {
                      await launch("tel://911");
                      CustomNavigator.pop();
                    },
                    title: "SOS",
                    description: getTranslated("call_emergency", context)),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Row(
                children: [
                  customImageIconSVG(imageName: SvgImages.emergency_call),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      getTranslated("call_emergency", context),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 1,
              width: context.width,
              color: Styles.LIGHT_GREY_BORDER,
              child: const SizedBox(),
            ),
          ),
          InkWell(
            onTap: () {
              onFinish?.call();
              CustomNavigator.pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.car, color: Styles.DISABLED),
                      Transform.rotate(
                        angle: -6 / 12,
                        child: Container(
                          height: 2,
                          width: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Styles.DISABLED,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      getTranslated("end_ride", context),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

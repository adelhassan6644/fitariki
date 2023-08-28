import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                  text: getTranslated("vehicle_arrival_approx", context),
                  style: AppTextStyles.w700.copyWith(
                      fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
                  children: [
                    TextSpan(
                      text:
                          "  ${DateTime.now().dateFormat(format: "hh:mm a", lang: "en")}",
                      style: AppTextStyles.w700
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                    )
                  ]),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "30 min - 3.1 km",
            style: AppTextStyles.w700
                .copyWith(fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}

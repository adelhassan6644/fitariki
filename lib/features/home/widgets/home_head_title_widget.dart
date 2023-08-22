import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class HomeHeadTitleWidget extends StatelessWidget {
  const HomeHeadTitleWidget({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onTap,
            child: Text(
              getTranslated("show_all", context),
              style: AppTextStyles.w400
                  .copyWith(fontSize: 11, color: Styles.DISABLED),
            ),
          ),
        ],
      ),
    );
  }
}

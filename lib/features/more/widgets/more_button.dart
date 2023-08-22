import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title,
      required this.icon,
      this.onTap,
      this.leading,
      this.withBorder = true,
      this.isLogout = false,
      Key? key})
      : super(key: key);
  final bool withBorder;
  final bool isLogout;
  final String title, icon;
  final void Function()? onTap;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          customImageIconSVG(
              imageName: icon,
              height: 14,
              width: 14,
              color: isLogout
                  ? Styles.FAILED_COLOR
                  : Styles.SECOUND_PRIMARY_COLOR),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: withBorder
                      ? const Border(
                          bottom:
                              BorderSide(color: Styles.HINT_COLOR, width: 0.5))
                      : null),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(title,
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: isLogout
                                ? Styles.FAILED_COLOR
                                : Styles.SECOUND_PRIMARY_COLOR)),
                  ),
                  leading != null
                      ? leading!
                      : !isLogout
                          ? const Icon(
                              Icons.arrow_forward_ios,
                              color: Styles.DISABLED,
                              size: 16,
                            )
                          : const SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

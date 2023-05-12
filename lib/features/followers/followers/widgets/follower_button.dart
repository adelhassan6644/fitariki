import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/utils/text_styles.dart';

class FollowerButton extends StatelessWidget {
  const FollowerButton({required this.title, this.onTap, Key? key})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: ColorResources.HINT_COLOR, width: 0.5))),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(title,
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                            color: ColorResources.SECOUND_PRIMARY_COLOR)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorResources.DISABLED,
                    size: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class AddOfferAppBar extends StatelessWidget {
  const AddOfferAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [   Center(
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
      SizedBox(height: 10.h),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 33,
            ),
            const Expanded(child: SizedBox()),
            Text(
              getTranslated("make_an_offer_to_captain", context),
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              child: SizedBox(
                width: 33,
                child: Text(
                  getTranslated("send", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 1,
          width: context.width,
          color: ColorResources.LIGHT_GREY_BORDER,
          child: const SizedBox(),
        ),
      ),],);
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/profile/widgets/profile_button.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: ColorResources.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ]),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            ProfileButton(
              title: getTranslated("personal_information", context),
              icon: SvgImages.file,
              onTap:()=> CustomNavigator.push(Routes.EDIT_PROFILE,arguments: false),
            ),
            ProfileButton(
              title: getTranslated("followers", context),
              icon: SvgImages.addFollower,
            ),
            ProfileButton(
              title: getTranslated("archives", context),
              icon: SvgImages.bookMark,
            ),
            ProfileButton(
              title: getTranslated("alerts", context),
              icon: SvgImages.alert,
            ),
            ProfileButton(
              title: getTranslated("bank_data", context),
              icon: SvgImages.card,
            ),
            ProfileButton(
              title: getTranslated("captain_evaluation", context),
              icon: SvgImages.rate,
            ),
            ProfileButton(
              title: getTranslated("contact_with_us", context),
              icon: SvgImages.call,
            ),
            ProfileButton(
              title: getTranslated("log_out", context),
              icon: SvgImages.logout,
              withBorder: false,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }
}

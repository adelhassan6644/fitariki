import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../app/core/utils/dimensions.dart';
import '../../components/custom_button.dart';
import '../../components/custom_show_model_bottom_sheet.dart';
import '../auth/pages/login.dart';

class GuestMode extends StatelessWidget {
  const GuestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Text(
            getTranslated("register_with_us", context),
            style: AppTextStyles.w600
                .copyWith(fontSize: 32, color: Styles.PRIMARY_COLOR),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            getTranslated(
                "and_enjoy_all_the_features_available_in_the_application",
                context),
            style: AppTextStyles.w500.copyWith(
                fontSize: 12, color: Styles.SECOUND_PRIMARY_COLOR),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CustomButton(
              text: getTranslated("login", context),
              onTap: () => customShowModelBottomSheet(
                body: const Login(),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),

        ],
      ),
    );
  }
}

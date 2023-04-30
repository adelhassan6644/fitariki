import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_app_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({this.fromLogin = false, Key? key}) : super(key: key);
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
            title: fromLogin == true
                ? getTranslated(
                    "complete_the_registration_information", context)
                : getTranslated("modification_of_personal_data", context),
            withBorder: true),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("",
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

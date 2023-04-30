import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../provider/edit_profile_provider.dart';

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
        Consumer<EditProfileProvider>(builder: (_, provider, child) {
          return Expanded(
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
                      Center(
                        child: Text(getTranslated("welcome", context),
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 32,
                                color: ColorResources.PRIMARY_COLOR)),
                      ),
                      Center(
                        child: Text(
                            getTranslated("edit_profile_description", context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.w500.copyWith(
                              fontSize: 16,
                            )),
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ],
            ),
          );
        })
      ],
    ));
  }
}

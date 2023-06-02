import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../provider/profile_provider.dart';
import '../widgets/bank_data_widget.dart';
import '../widgets/car_data_widget.dart';
import '../widgets/personal_information_widget.dart';
import '../widgets/profile_image_widget.dart';
import '../widgets/welcome_widget.dart';
import '../widgets/work_information_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.fromLogin, Key? key}) : super(key: key);
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ProfileProvider>(builder: (_, provider, child) {
      return SafeArea(
        bottom: true,
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
                withBack: !fromLogin,
                actionChild: fromLogin
                    ? null
                    : GestureDetector(
                        onTap: () => provider.updateProfile(),
                        child: Text(getTranslated("save", context),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                                color: ColorResources.SYSTEM_COLOR)),
                      ),
                title: fromLogin
                    ? getTranslated(
                        "complete_the_registration_information", context)
                    : getTranslated("modification_of_personal_data", context),
                withBorder: true),
            // if(!provider.isLoading)
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
                        Visibility(
                            visible:fromLogin ,
                            child: const WelcomeWidget()),
                        ProfileImageWidget(
                          provider: provider,
                          fromLogin: fromLogin,
                        ),
                        PersonalInformationWidget(
                          provider: provider,
                        ),
                        Visibility(
                          visible: provider.isDriver,
                          child: CarDataWidget(
                            provider: provider,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        WorkInformationWidget(
                          provider: provider,
                        ),
                        Visibility(
                            visible: provider.isDriver,
                            child: BankDataWidget(
                              provider: provider,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (fromLogin)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: CustomButton(
                      text: getTranslated("save", context),
                      onTap: () => provider.updateProfile(),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
          ],
        ),
      );
    }));
  }
}

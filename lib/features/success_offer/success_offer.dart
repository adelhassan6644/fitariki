import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:fitariki/main_widgets/custom_button.dart';
import 'package:fitariki/main_widgets/custom_images.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/images.dart';
import '../../navigation/routes.dart';

class SuccessPost extends StatelessWidget {
  const SuccessPost({required this.name, Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: customImageIcon(
                    imageName: Images.doneCircle, width: 165, height: 165),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Text(
                  getTranslated("congratulations", context),
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 32, color: ColorResources.PRIMARY_COLOR),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  child: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.role == "driver"
                            ? getTranslated("sent_offer_successfully", context)
                            : getTranslated(
                                "sent_request_successfully", context),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 16,
                            color: ColorResources.SECOUND_PRIMARY_COLOR),
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                text: getTranslated("my_trips", context),
                onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                    clean: true, arguments: 1),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(
                onTap: () {
                  if(name != ""){
                    CustomNavigator.pop();
                  }else {
                    CustomNavigator.push(Routes.DASHBOARD,
                        clean: true, arguments: 0);
                  }
                },
                text: getTranslated("close", context),
                backgroundColor: ColorResources.WHITE_COLOR,
                withBorderColor: true,
                textColor: ColorResources.PRIMARY_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

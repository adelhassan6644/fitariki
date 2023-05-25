import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../app/core/utils/images.dart';
import '../../components/custom_button.dart';
import '../../components/custom_images.dart';
import '../../navigation/routes.dart';
import 'model/success_model.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({required this.successModel, Key? key}) : super(key: key);
  final SuccessModel successModel;

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
                  successModel.isCongrats!
                      ? getTranslated("congratulations", context)
                      : getTranslated("has_been_sent", context),
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 32, color: ColorResources.PRIMARY_COLOR),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0.h),
                  child: SubstringHighlight(
                    textAlign: TextAlign.center,
                    text: successModel.description!, // search result string from database or something
                    term: successModel.title ?? "iiiiiii",
                    textStyle: AppTextStyles.w500.copyWith(
                        fontSize: 16,
                        color: ColorResources.SECOUND_PRIMARY_COLOR),
                    textStyleHighlight: AppTextStyles.w700.copyWith(
                        fontSize: 16,
                        color: ColorResources.SECOUND_PRIMARY_COLOR),
                  ),
                ),
              ),
              CustomButton(
                text: successModel.btnText ?? "في طريقي",
                onTap: () {
                  if (successModel.routeName != null) {
                    CustomNavigator.push(successModel.routeName!,
                        clean: successModel.isClean??false, replace: successModel.isReplace??false,arguments: successModel.argument??0);
                  } else {
                    CustomNavigator.push(
                      Routes.DASHBOARD,
                      clean: true,
                      arguments: 0
                    );
                  }
                },
              ),

                SizedBox(
                  height: 8.h,
                ),

                CustomButton(
                  onTap: () {
                    CustomNavigator.push(
                      Routes.DASHBOARD,
                      clean: true,
                      arguments: 0
                    );
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

import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/feedback_provider.dart';

class RateUser extends StatelessWidget {
  const RateUser({required this.userId, Key? key}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<FeedbackProvider>(builder: (_, provider, child) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 130.h + context.toPadding,
                ),
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
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.h,
                    ),
                    child: SubstringHighlight(
                      textAlign: TextAlign.center,
                      text: "تم انتهاء رحلتك مع كابتن محمد م...",
                      term: "محمد م...",
                      textStyle: AppTextStyles.w500.copyWith(
                          fontSize: 16,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                      textStyleHighlight: AppTextStyles.w700.copyWith(
                          fontSize: 16,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                    ),
                  ),
                ),

                ///Rate Count
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: GestureDetector(
                          onTap: () => provider.selectedRate(index),
                          child: customImageIconSVG(
                            height: 20,
                            width: 20,
                            imageName: provider.ratting! < index
                                ? SvgImages.emptyStar
                                : SvgImages.fillStar,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ///Rate Message
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: CustomTextFormField(
                      hint: getTranslated("rate_trip", context),
                      minLine: 5,
                      maxLine: 5,
                      controller: provider.feedback,
                      keyboardAction: TextInputAction.newline),
                ),

                ///Send Rate
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: CustomButton(
                    text: getTranslated("submit", context),
                    onTap: () =>
                        provider.sendFeedback(offerId: 1, userId: userId),
                    isLoading: provider.isSendRate,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: CustomButton(
                    text: getTranslated("skip", context),
                    backgroundColor: ColorResources.WHITE_COLOR,
                    withBorderColor: true,
                    textColor: ColorResources.PRIMARY_COLOR,
                    onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                        arguments: 0, clean: true),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

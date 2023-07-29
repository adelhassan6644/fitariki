import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../provider/main_feedback_provider.dart';

class RateTrip extends StatelessWidget {
  const RateTrip({required this.data, Key? key}) : super(key: key);
  final RateUserNavigationModel data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: getTranslated("rate", context),
              withBack: true,
              withBorder: true,
            ),
            Expanded(
              child: Consumer<SendFeedbackProvider>(builder: (_, provider, child) {
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
                            imageName: Images.doneCircle,
                            width: 165,
                            height: 165),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                        child: Text(
                          getTranslated("congratulations", context),
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 32,
                              color: Styles.PRIMARY_COLOR),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0.h,
                          ),
                          child: SubstringHighlight(
                            textAlign: TextAlign.center,
                            text:
                                "${getTranslated("your_trip_end_with", context)} ${getTranslated(data.isDriver! ? "passenger" : "captain", context)} ${data.name}",
                            term: data.name,
                            textStyle: AppTextStyles.w500.copyWith(
                                fontSize: 16,
                                color: Styles.SECOUND_PRIMARY_COLOR),
                            textStyleHighlight: AppTextStyles.w700.copyWith(
                                fontSize: 16,
                                color: Styles.SECOUND_PRIMARY_COLOR),
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
                          onTap: () => provider.sendFeedback(
                              offerId: data.offerId ?? 0,
                              userId: data.userId ?? 0),
                          isLoading: provider.isSendFeedback,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 8.0.h),
                      //   child: CustomButton(
                      //     text: getTranslated("skip", context),
                      //     backgroundColor: ColorResources.WHITE_COLOR,
                      //     withBorderColor: true,
                      //     textColor: ColorResources.PRIMARY_COLOR,
                      //     onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                      //         arguments: 0, clean: true),
                      //   ),
                      // ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class RateUserNavigationModel {
  int? userId, offerId;
  bool? isDriver;
  String? name;
  RateUserNavigationModel(
      {this.offerId, this.userId, this.name, this.isDriver});
}

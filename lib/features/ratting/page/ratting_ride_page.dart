import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/ratting/provider/ratting_provider.dart';
import 'package:fitariki/features/ratting/repo/ratting_repo.dart';
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
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class RattingRidePage extends StatelessWidget {
  const RattingRidePage({required this.data, Key? key}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ChangeNotifierProvider(
              create: (_) => RattingProvider(repo: sl<RattingRepo>()),
              child: Consumer<RattingProvider>(builder: (_, provider, child) {
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

                      Padding(
                        padding: EdgeInsets.only(
                          top: 40.h,
                          bottom: 16.0.h,
                        ),
                        child: Center(
                          child: Text(
                            getTranslated("your_ride_is_ended", context),
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 32, color: Styles.PRIMARY_COLOR),
                          ),
                        ),
                      ),
                      Center(
                        child: SubstringHighlight(
                          textAlign: TextAlign.center,
                          text:
                              "${getTranslated("you_have", context)} ${data["number"]} ${getTranslated("ride_remaining_with", context)} ${getTranslated(provider.isDriver ? "the_passenger" : "the_captain", context)} ${data["name"]}",
                          term: data["name"],
                          textStyle: AppTextStyles.w500.copyWith(
                              fontSize: 16,
                              color: Styles.SECOUND_PRIMARY_COLOR),
                          textStyleHighlight: AppTextStyles.w700.copyWith(
                              fontSize: 16,
                              color: Styles.SECOUND_PRIMARY_COLOR),
                        ),
                      ),

                      ///Rate Count
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated("the_rate", context),
                              style: AppTextStyles.w500.copyWith(
                                  fontSize: 16,
                                  color: Styles.SECOUND_PRIMARY_COLOR),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: GestureDetector(
                                    onTap: () => provider.selectedRate(index),
                                    child: customImageIconSVG(
                                      height: 20,
                                      width: 20,
                                      imageName: provider.ratting < index
                                          ? SvgImages.emptyStar
                                          : SvgImages.fillStar,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Send Rate
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: CustomButton(
                          text: getTranslated("submit", context),
                          onTap: () => provider.sendRate(data["id"] as int),
                          isLoading: provider.isLoading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: CustomButton(
                          text: getTranslated("skip", context),
                          backgroundColor: Styles.WHITE_COLOR,
                          withBorderColor: true,
                          textColor: Styles.PRIMARY_COLOR,
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
          ),
        ],
      ),
    );
  }
}

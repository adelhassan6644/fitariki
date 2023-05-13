import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/app/localization/provider/localization_provider.dart';
import 'package:fitariki/features/on_boarding/widgets/step_widget.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController(initialPage: 0);
  final PageController pageController2 = PageController(initialPage: 0);
  int currentIndex = 0;

  nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    pageController2.animateToPage(pageController2.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    currentIndex = pageController.page!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: ((index) => setState(() {
                          currentIndex = index;
                        })),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Images.onBoarding1,
                            fit: BoxFit.fitWidth,
                            width: context.width,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Images.onBoarding2,
                            fit: BoxFit.fitWidth,
                            width: context.width,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 310,
              width: context.width,
              decoration: const BoxDecoration(
                  color: ColorResources.WHITE_COLOR,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(25), right: Radius.circular(25))),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  StepWidget(
                    currentIndex: currentIndex,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController2,
                      onPageChanged: ((index) => setState(() {
                            currentIndex = index;
                          })),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "توافق مشواركم اليومي",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 20,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                            Text(
                              " موضح بالنسب ٪",
                              style: AppTextStyles.w600.copyWith(
                                fontSize: 35,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                            Text(
                              "لنضمن طريقة توصيل سهلة و سريعة ...",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 15,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "الراكب بإمكانه اضافة",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 20,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                            Text(
                              "تابعين له",
                              style: AppTextStyles.w600.copyWith(
                                fontSize: 35,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                            Text(
                              "ابنك/ابنتك/صاحبتك ...",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 15,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                            Text(
                              "للبحث لهم عن كابتن مناسب",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 15,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                            clean: true, arguments: 0),
                        child: Text(
                          getTranslated("skip", context),
                          style: AppTextStyles.w500.copyWith(
                            fontSize: 13,
                            color: ColorResources.DISABLED,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (currentIndex == 0) {
                            setState(() {
                              nextPage();
                            });
                          } else {
                            CustomNavigator.push(Routes.DASHBOARD,
                                clean: true, arguments: 0);
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated("continue", context),
                              style: AppTextStyles.w600.copyWith(
                                height: 1.25,
                                fontSize: 15,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                            RotatedBox(
                                quarterTurns: Provider.of<LocalizationProvider>(
                                            context,
                                            listen: false)
                                        .isLtr
                                    ? 0
                                    : 2,
                                child: customImageIconSVG(
                                    imageName: SvgImages.arrowRightAlt))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

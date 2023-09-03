import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class HomeRunningRidesWidget extends StatelessWidget {
  const HomeRunningRidesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return provider.isCheck
          ? Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_DEFAULT,
                  0,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  24),
              child: CustomShimmerContainer(
                height: 75.h,
                radius: 8,
              ),
            )
          : AnimatedCrossFade(
              crossFadeState: provider.goingDown
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 500),
              firstChild: SizedBox(width: context.width),
              secondChild: Visibility(
                visible: provider.hasRides && provider.isLogin,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      0,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      24),
                  child: InkWell(
                    onTap: () => CustomNavigator.push(Routes.MY_RIDES),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            colors: [Color(0xFFE8FFEF), Colors.white],
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54.withOpacity(0.1),
                              blurRadius: 7.0,
                              spreadRadius: -1,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customImageIconSVG(
                              imageName: SvgImages.homeCalendar,
                              width: 20,
                              height: 20),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated("running_trips", context),
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 14, color: Colors.black)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  getTranslated(
                                      "monitor_your_rides_in_one_place",
                                      context),
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10, color: Styles.DISABLED)),
                            ],
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          customImageIconSVG(
                              imageName: SvgImages.runningTrips,
                              width: 30,
                              height: 30),
                        ],
                      )
                          .animate(
                            onComplete: (c) => c.repeat(),
                          )
                          .shimmer(duration: 1000.ms),
                    ),
                  ),
                ),
              ));
    });
  }
}

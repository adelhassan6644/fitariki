import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/marquee_widget.dart';
import '../components/rate_stars.dart';
import '../features/home/widgets/acceptable_analytics_widget.dart';

class CaptainCard extends StatelessWidget {
  const CaptainCard(
      {this.daysNum,
      this.daysNumInWeek,
      this.days,
      this.timeRange,
      this.priceRange,
      this.withAnalytics = true,
      Key? key})
      : super(key: key);
  final bool withAnalytics;
  final String? daysNumInWeek, daysNum, days, timeRange, priceRange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: ColorResources.WHITE_COLOR,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 1,
                offset: const Offset(0, 2))
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomNetworkImage.circleNewWorkImage(
                        image:
                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                        radius: 28,
                        color: ColorResources.SECOUND_PRIMARY_COLOR),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                "محمد م..",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 14,
                                    height: 1.25,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            customImageIconSVG(
                                imageName: SvgImages.maleIcon,
                                color: ColorResources.BLUE_COLOR,
                                width: 11,
                                height: 11)
                          ],
                        ),
                        const RateStars(
                          rate: 3,
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            "سعودي",
                            maxLines: 1,
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                                height: 1.25,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.roadLine),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              "$daysNum يوم ",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        color: ColorResources.HINT_COLOR,
                        height: 30,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.calendar),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              days ?? "",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: ColorResources.HINT_COLOR,
                        height: 30,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.alarm),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              timeRange ?? "9 صباحاً - 5 مساءً",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: ColorResources.HINT_COLOR,
                        height: 30,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.wallet),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              priceRange ?? "",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$daysNumInWeek ايام",
                  style: AppTextStyles.w400.copyWith(fontSize: 10, height: 1),
                ),
                if (withAnalytics)
                  const AcceptableAnalytics(
                    value: 50,
                    color: ColorResources.PRIMARY_COLOR,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/marquee_widget.dart';
import '../components/rate_stars.dart';
import '../navigation/routes.dart';
import '../features/home/widgets/acceptable_analytics_widget.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({this.isSaved = false, Key? key}) : super(key: key);
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(Routes.OFFER_DETAILS),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.2),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage.circleNewWorkImage(
                            image:
                                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                            radius: 16,
                            color: ColorResources.SECOUND_PRIMARY_COLOR),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              )
                            ],
                          ),
                        ),
                        if (isSaved == true)
                          InkWell(
                            onTap: () {},
                            child:
                                customImageIconSVG(imageName: SvgImages.saved),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.roadLine),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "20-12 يوم",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  color: ColorResources.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex:isSaved?7 : 5,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "3 ايام بالإسبوع",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.alarm),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "9 صباحاً - 5 مساءً",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  color: ColorResources.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: isSaved?7 :5,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.wallet),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "400 - 600 ريال",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (isSaved != true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "4 ايام",
                      style: AppTextStyles.w400.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AcceptableAnalytics(
                      value: 50,
                      color: ColorResources.PRIMARY_COLOR,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

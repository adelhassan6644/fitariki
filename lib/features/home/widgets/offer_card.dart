import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/main_widgets/custom_images.dart';
import 'package:fitariki/main_widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../../../main_widgets/rate_stars.dart';
import 'accaptable_analytics_widget.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
           boxShadow: [
             BoxShadow(
                 color: Colors.black54.withOpacity(0.2),
                 blurRadius: 7.0,
                 spreadRadius: -1,
                 offset: const Offset(0,2)
             )
           ],),
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
                          image: "",
                          radius: 16,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "محمد م...",
                                maxLines: 1,
                                style: AppTextStyles.w600.copyWith(fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.male,
                                color: ColorResources.BLUE_COLOR,
                                size: 16,
                              )
                            ],
                          ),
                          const RateStars(
                            rate: 3,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      customImageIconSVG(imageName: SvgImages.roadLine),
                      const SizedBox(width: 4),
                      Text(
                        "20-12 يوم",
                        style: AppTextStyles.w400.copyWith(fontSize: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          color: ColorResources.HINT_COLOR,
                          height: 10,
                          width: 1,
                          child: const SizedBox(),
                        ),
                      ),
                      customImageIconSVG(imageName: SvgImages.calendar),
                      const SizedBox(width: 4),
                      Text(
                        "3 ايام بالإسبوع",
                        style: AppTextStyles.w400.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      customImageIconSVG(imageName: SvgImages.alarm),
                      const SizedBox(width: 4),
                      Text(
                        "9 صباحاً - 5 مساءً",
                        style: AppTextStyles.w400.copyWith(fontSize: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          color: ColorResources.HINT_COLOR,
                          height: 10,
                          width: 1,
                          child: const SizedBox(),
                        ),
                      ),
                      customImageIconSVG(imageName: SvgImages.wallet),
                      const SizedBox(width: 4),
                      Text(
                        "400 - 600 ريال",
                        style: AppTextStyles.w400.copyWith(fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("4 ايام",style: AppTextStyles.w400.copyWith(fontSize: 10),),
                const SizedBox(height: 10,),
                const AcceptableAnalytics(
                    value:  50,
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

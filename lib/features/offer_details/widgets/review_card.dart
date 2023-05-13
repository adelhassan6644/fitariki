import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/rate_stars.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                    width: 1)),
            child: Column(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                "محمد م..",
                                maxLines: 1,
                                textAlign: TextAlign.start,
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
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    "“عرض جيد و كابتن محترم”.",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: AppTextStyles.w400
                        .copyWith(fontSize: 10, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 4,
              left: 10,
              child: Text(
                "5 ايام",
                style: AppTextStyles.w400
                    .copyWith(color: ColorResources.HINT_COLOR, fontSize: 10),
              ))
        ],
      ),
    );
  }
}

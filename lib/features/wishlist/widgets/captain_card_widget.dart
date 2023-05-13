import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/rate_stars.dart';

class CaptainCardWidget extends StatelessWidget {
  const CaptainCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
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
                          width: 60,
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
              InkWell(
                onTap: () {},
                child: customImageIconSVG(imageName: SvgImages.saved),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("car_details", context),
            style: AppTextStyles.w600.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.car,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                "كامري، تايوتا",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: ColorResources.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.file,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                "2023",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: ColorResources.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.seat,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                "5 اشخاص",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

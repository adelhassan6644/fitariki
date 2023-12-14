import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/features/profile/model/driver_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({this.carInfo ,Key? key}) : super(key: key);
 final CarInfo? carInfo;

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
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                carInfo?.name??"",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: Styles.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.carModel,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                carInfo?.model??  "",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: Styles.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.seat,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              const SizedBox(
                width: 4,
              ),
              Text(
                "${carInfo?.seatsCount} اشخاص",
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

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

import '../../../components/custom_images.dart';
import '../../../components/expansion_tile_widget.dart';

class CarTripDetailsWidget extends StatelessWidget {
  const CarTripDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: ExpansionTileWidget(
        iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
        title: getTranslated("car_data", context),
        children: [
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.car,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
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
                  imageName: SvgImages.carModel,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "2024",
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
              SizedBox(
                width: 4.w,
              ),
              Text(
                "5 اشخاص",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.carPlate,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "7653 TNJ",
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
                  imageName: SvgImages.carColor,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "ابيض",
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
              Text(
                "عرض صورة السيارة",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

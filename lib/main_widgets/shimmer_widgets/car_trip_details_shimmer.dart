import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/custom_images.dart';
import '../../components/shimmer/custom_shimmer.dart';

class CarTripDetailsShimmer extends StatelessWidget {
  const CarTripDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("car_details", context),
            style: AppTextStyles.w600.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8.h,
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
              CustomShimmerContainer(
                width: 50.w,
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
              const SizedBox(
                width: 4,
              ),
              CustomShimmerContainer(
                width: 50.w,
                height: 12.h,
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
              CustomShimmerContainer(
                width: 50.w,
                height: 12.h,
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
              CustomShimmerContainer(
                width: 50.w,
                height: 12.h,
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
              CustomShimmerContainer(
                width: 50.w,
                height: 12.h,
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
              CustomShimmerContainer(
                width: 100.w,
                height: 12.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

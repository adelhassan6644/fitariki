import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/animated_widget.dart';
import '../../components/custom_images.dart';
import '../../components/expansion_tile_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';
import 'distance_widget_shimmer.dart';
import 'map_widget_shimmer.dart';

class RequestDetailsShimmer extends StatelessWidget {
  const RequestDetailsShimmer({this.isDriver = false, Key? key})
      : super(key: key);
  final bool isDriver;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        data: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: CustomShimmerContainer(
              width: context.width,
              height: 126.h,
              radius: 8,
            ),
          ),
          MapWidgetShimmer(
            withStops: isDriver,
          ),
          const DistanceWidgetShimmer(),
          Visibility(
            visible: !isDriver,
            child: Padding(
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
            ),
          ),
          Visibility(
              visible: isDriver,
              child: MapWidgetShimmer(
                withClientName: isDriver,
              )),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: ExpansionTileWidget(
              iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
              title: getTranslated("trip_details", context),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("start_of_duration", context),
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                            color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(4)),
                        child: CustomShimmerContainer(
                          width: 100.w,
                          height: 12.h,
                        ))
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomShimmerContainer(
                  width: context.width,
                  height: 126.h,
                  radius: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

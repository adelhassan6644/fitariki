import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/map_widget_shimmer.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/reviews_widget_shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/custom_images.dart';
import 'distance_widget_shimmer.dart';

class OfferDetailsShimmer extends StatelessWidget {
  const OfferDetailsShimmer({required this.isDriver, Key? key})
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
                  )
                ],
              ),
            ),
          ),
          Visibility(
              visible: isDriver,
              child: MapWidgetShimmer(
                withClientName: isDriver,
              )),
          // Visibility(visible: !isDriver, child: const ReviewWidgetShimmer()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/dimensions.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../app/localization/localization/language_constant.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/custom_images.dart';
import '../../../../components/shimmer/custom_shimmer.dart';

class PreviousTripDetailsShimmer extends StatelessWidget {
  const PreviousTripDetailsShimmer({super.key, required this.isDriver});
  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      data: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomShimmerCircleImage(diameter: 40),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CustomShimmerText(width: 100),
                        SizedBox(width: 4),
                        CustomShimmerCircleImage(diameter: 12),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Expanded(flex: 3, child: CustomShimmerText()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            color: Styles.HINT_COLOR,
                            height: 10,
                            width: 1,
                            child: const SizedBox(),
                          ),
                        ),
                        const Expanded(flex: 2, child: CustomShimmerText()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            color: Styles.HINT_COLOR,
                            height: 10,
                            width: 1,
                            child: const SizedBox(),
                          ),
                        ),
                        const Expanded(child: CustomShimmerText()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///Map Shimmer
        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: CustomShimmerContainer(
            height: 120,
            radius: 12,
          ),
        ),

        ///Location Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.dotIcon, width: 10, height: 10),
                  const SizedBox(width: 4),
                  const Expanded(child: CustomShimmerText()),
                  const SizedBox(width: 45),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Container(
                  height: 12,
                  width: 2,
                  color: Styles.HINT_COLOR,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.dotIcon, width: 10, height: 10),
                  const SizedBox(width: 4),
                  const Expanded(child: CustomShimmerText()),
                  const SizedBox(width: 45),
                ],
              ),
            ],
          ),
        ),

        ///Invoice Shimmer
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Divider(
                thickness: 1,
                color: Styles.LIGHT_BORDER_COLOR,
              ),
            ),

            ///Payment details
            Visibility(
              visible: !isDriver,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated("payment", context),
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getTranslated("trip_amount", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const CustomShimmerText(width: 100),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "${getTranslated("tax", context)}  ",
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const CustomShimmerText(width: 20),
                                ],
                              ),
                            ),
                            const CustomShimmerText(width: 100),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "${getTranslated("service_costs", context)}  ",
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  CustomShimmerText(width: 20),
                                ],
                              ),
                            ),
                            CustomShimmerText(width: 100),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Divider(
                      thickness: 1,
                      color: Styles.LIGHT_BORDER_COLOR,
                    ),
                  ),
                ],
              ),
            ),

            ///Final amount
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("absence_days", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const CustomShimmerText(width: 100),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("absence_cost", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const CustomShimmerText(width: 100),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("final_amount", context),
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const CustomShimmerText(width: 100),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),

        ///Invoice button
        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: 24, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: CustomShimmerContainer(
            height: 50,
            radius: 16,
          ),
        ),
      ],
    );
  }
}

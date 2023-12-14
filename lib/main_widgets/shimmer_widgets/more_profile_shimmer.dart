import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../components/custom_images.dart';
import '../../components/shimmer/custom_shimmer.dart';

class MoreProfileShimmer extends StatelessWidget {
  const MoreProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: Styles.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ]),
        child: Row(
          children: [
            const CustomShimmerCircleImage(
              diameter: 72,
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CustomShimmerContainer(
                      width: 50.w,
                      height: 12.h,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomShimmerContainer(
                      width: 25.w,
                      height: 12.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomShimmerContainer(
                  width: 70.w,
                  height: 12.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomShimmerContainer(
                  width: 50.w,
                  height: 12.h,
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              width: 0.5.w,
              height: 48.h,
              color: Styles.HINT_COLOR,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(imageName: SvgImages.completed),
                SizedBox(
                  height: 10.h,
                ),
                CustomShimmerContainer(
                  width: 70.w,
                  height: 12.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomShimmerContainer(
                  width: 35.w,
                  height: 12.h,
                ),
              ],
            ),
          ],
        ));
  }
}

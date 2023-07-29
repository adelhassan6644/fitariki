import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/custom_images.dart';

class ReviewWidgetShimmer extends StatelessWidget {
  const ReviewWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("display_stats", context),
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                   CustomShimmerContainer(width: 50.w,height: 12.h,),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.profileIcon,
                        color: Styles.SECOUND_PRIMARY_COLOR,
                        height: 14,
                        width: 14),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomShimmerContainer(width: 150.w,height: 12.h,),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                ...List.generate(5, (index) =>  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: CustomShimmerContainer(width: 145.w,height: 90.h,radius: 8,),
                )),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

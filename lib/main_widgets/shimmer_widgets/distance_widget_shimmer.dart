import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/svg_images.dart';
import '../../components/custom_images.dart';

class DistanceWidgetShimmer extends StatelessWidget {
  const DistanceWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
            imageName: SvgImages.sparkles,
            color: Styles.PRIMARY_COLOR,
          ),
           SizedBox(
            width: 4.w,
          ),
         CustomShimmerContainer(width: 250.w,height: 12.h,)
        ],
      ),
    );
  }
}

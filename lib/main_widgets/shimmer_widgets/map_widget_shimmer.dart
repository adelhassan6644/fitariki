import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';

class MapWidgetShimmer extends StatelessWidget {
  const MapWidgetShimmer({this.withStops = false ,this.withClientName = false , Key? key}) : super(key: key);
  final bool withStops;
  final bool withClientName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        children: [
          if (withClientName)
            Center(child: CustomShimmerContainer(width: 150.w,height: 12,)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated("start_point", context),
                        maxLines: 1,
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 10, overflow: TextOverflow.ellipsis),
                      ),
                 SizedBox(height: 8.h,),
                 CustomShimmerContainer(height:12.h,)
                    ],
                  ),
                ),
                SizedBox(width: 15.w),
                if (withStops)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getTranslated("stop_points", context),
                          maxLines: 1,
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 10, overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 8.h,),
                        CustomShimmerContainer(height:12.h,)
                      ],
                    ),
                  ),
                if (withStops) SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated("final_destination", context),
                        maxLines: 1,
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 10, overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 8.h,),
                      CustomShimmerContainer(height:12.h,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        CustomShimmerContainer(width: context.width,height: 125.h,radius: 8,)
        ],
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/animated_widget.dart';
import '../../components/expansion_tile_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';
import 'car_trip_details_shimmer.dart';
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

          ///Request Details
          ExpansionTileWidget(
            iconColor: Styles.SECOUND_PRIMARY_COLOR,
            withTitlePadding: true,
            title: getTranslated("details", context),
            children: [
              MapWidgetShimmer(
                withStops: isDriver,
              ),
              const DistanceWidgetShimmer(),
              Visibility(
                visible: !isDriver,
                child: const CarTripDetailsShimmer(),
              ),
              Visibility(
                  visible: isDriver,
                  child: MapWidgetShimmer(
                    withClientName: isDriver,
                  )),

              ///Type of ride
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated("ride_type", context),
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomShimmerContainer(
                      width: 200.w,
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///Trip Details
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: ExpansionTileWidget(
              iconColor: Styles.SECOUND_PRIMARY_COLOR,
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
                            color: Styles.PRIMARY_COLOR.withOpacity(0.06),
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

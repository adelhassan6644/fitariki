import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/animated_widget.dart';
import '../../components/expansion_tile_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';
import '../../data/config/di.dart';
import '../../features/profile/provider/profile_provider.dart';
import 'map_widget_shimmer.dart';

class MyOfferDetailsShimmer extends StatelessWidget {
  const MyOfferDetailsShimmer({Key? key, required this.isDriver})
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
              height: 85.h,
              radius: 8,
            ),
          ),

          ///My Offer Details
          ExpansionTileWidget(
            iconColor: Styles.SECOUND_PRIMARY_COLOR,
            withTitlePadding: true,
            title: getTranslated(
                isDriver
                    ? "delivery_offer_details"
                    : "delivery_request_details",
                context),
            children: [
              ///Offer Map
              const MapWidgetShimmer(),

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

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 16.h),
            child: Text(
              sl.get<ProfileProvider>().isDriver
                  ? getTranslated("requests", context)
                  : getTranslated("offers", context),
              style: AppTextStyles.w600.copyWith(fontSize: 16),
            ),
          ),
          ...List.generate(
              3,
              (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: CustomShimmerContainer(
                      width: context.width,
                      height: 140.h,
                      radius: 8,
                    ),
                  )),
        ],
      ),
    );
  }
}

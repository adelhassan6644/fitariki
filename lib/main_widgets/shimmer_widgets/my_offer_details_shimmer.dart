import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/animated_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';
import '../../data/config/di.dart';
import '../../features/profile/provider/profile_provider.dart';
import 'map_widget_shimmer.dart';

class MyOfferDetailsShimmer extends StatelessWidget {
  const MyOfferDetailsShimmer({Key? key}) : super(key: key);
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
          const MapWidgetShimmer(),
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

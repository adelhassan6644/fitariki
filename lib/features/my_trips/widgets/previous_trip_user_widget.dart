import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/marquee_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class PreviousTripUserWidget extends StatelessWidget {
  const PreviousTripUserWidget(
      {super.key,
      this.image,
      this.name,
      this.gender = true,
      this.userId,
      this.timeRange,
      this.rideType,
      this.startDate});

  final int? userId, rideType;
  final String? image, name, timeRange;
  final DateTime? startDate;
  final bool gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => CustomNavigator.push(Routes.USER_PROFILE,
                arguments: {"id": userId, "my_profile": false}),
            child: CustomNetworkImage.circleNewWorkImage(
                image: image, radius: 20, color: Styles.SECOUND_PRIMARY_COLOR),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      name ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                          height: 1.25,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    customImageIconSVG(
                        imageName:
                            gender ? SvgImages.maleIcon : SvgImages.femaleIcon,
                        color: Styles.BLUE_COLOR,
                        width: 12,
                        height: 12)
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: MarqueeWidget(
                        child: Text(
                          "${getTranslated("start_date", context)} ${startDate?.dateFormat(format: "d MMM yyyy") ?? ""}",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: Styles.HINT_COLOR,
                        height: 10,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: MarqueeWidget(
                        child: Text(
                          timeRange ?? "",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: Styles.HINT_COLOR,
                        height: 10,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: MarqueeWidget(
                        child: Text(
                          Methods.getOfferType(rideType ?? 1),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

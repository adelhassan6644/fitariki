import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import '../app/core/utils/methods.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/marquee_widget.dart';
import '../components/show_rate.dart';
import '../data/config/di.dart';
import '../features/home/widgets/acceptable_analytics_widget.dart';
import '../features/request_details/widgets/contact_buttons.dart';
import '../features/request_details/widgets/report_button.dart';
import '../features/user_profile/provider/user_profile_provider.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {this.image,
      this.name,
      this.male = true,
      this.duration,
      this.createdAt,
      this.userId,
      this.reservationId,
      this.phone,
      this.days,
      this.rate,
      this.passengers,
      this.timeRange,
      this.national,
      this.priceRange,
      this.matching,
      this.withAnalytics = true,
      this.approved = false,
      Key? key})
      : super(key: key);

  final int? userId, reservationId, rate, passengers;
  final String? image, name, national, phone;
  final bool male;
  final double? matching;

  final String? duration, days, timeRange, priceRange;
  final bool withAnalytics;
  final bool approved;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: ColorResources.WHITE_COLOR,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 1,
                offset: const Offset(0, 2))
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (userId != null) {
                      sl<UserProfileProvider>().getUserProfile(
                        userId: userId!,
                      );

                      CustomNavigator.push(Routes.USER_PROFILE,
                          arguments: userId);
                    }
                    if (sl<UserProfileProvider>().isDriver && userId != null) {
                      sl<UserProfileProvider>().getUserFollowers(id: userId!);
                    }

                  },
                  child: Row(
                    children: [
                      CustomNetworkImage.circleNewWorkImage(
                          image: image,
                          radius: 28,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  name ?? "",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 14,
                                      height: 1.25,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              customImageIconSVG(
                                  imageName: male
                                      ? SvgImages.maleIcon
                                      : SvgImages.femaleIcon,
                                  color: ColorResources.BLUE_COLOR,
                                  width: 11,
                                  height: 11)
                            ],
                          ),
                          ShowRate(
                            rate: rate,
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              national ?? "",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  height: 1.25,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    /// to show days number
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.roadLine),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              "$duration ${getTranslated("day", context)}",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// to show followers number
                    Visibility(
                      visible:
                          sl<ProfileProvider>().isDriver && passengers != null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          color: ColorResources.HINT_COLOR,
                          height: 30,
                          width: 1,
                          child: const SizedBox(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          sl<ProfileProvider>().isDriver && passengers != null,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            customImageIconSVG(
                                imageName: SvgImages.addFollower),
                            const SizedBox(height: 4),
                            MarqueeWidget(
                              child: Text(
                                "$passengers",
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// to show days
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: ColorResources.HINT_COLOR,
                        height: 30,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.calendar),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              days ?? "",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// to show time range
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: ColorResources.HINT_COLOR,
                        height: 30,
                        width: 1,
                        child: const SizedBox(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          customImageIconSVG(imageName: SvgImages.alarm),
                          const SizedBox(height: 4),
                          MarqueeWidget(
                            child: Text(
                              timeRange ?? "",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// to show price range
                    Visibility(
                      visible: !approved,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          color: ColorResources.HINT_COLOR,
                          height: 30,
                          width: 1,
                          child: const SizedBox(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !approved,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            customImageIconSVG(imageName: SvgImages.wallet),
                            const SizedBox(height: 4),
                            MarqueeWidget(
                              child: Text(
                                priceRange ?? "",
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            approved
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ReportButton(
                        userId: userId!,
                        reservationId: reservationId!,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      ContactButtons(phone: phone ?? "")
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        createdAt == null
                            ? getTranslated("now", context)
                            : Methods.getDayCount(
                                date: createdAt!,
                              ).toString(),
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 10, height: 1),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      if (withAnalytics)
                         AcceptableAnalytics(
                          value: matching??0,
                          color: ColorResources.PRIMARY_COLOR,
                        ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

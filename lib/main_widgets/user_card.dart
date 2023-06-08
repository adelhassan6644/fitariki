import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import '../app/core/utils/methods.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/marquee_widget.dart';
import '../components/show_rate.dart';
import '../data/config/di.dart';
import '../features/home/widgets/acceptable_analytics_widget.dart';
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
      this.days,
      this.rate,  this.role,

      this.followers,
      this.timeRange,
      this.national,
      this.priceRange,
      this.withAnalytics = true,
      Key? key})
      : super(key: key);

  final int? userId, rate;
  final String? image, name, national;
  final bool male;
  final bool? role;

  final String? duration, days, timeRange, priceRange, followers;
  final bool withAnalytics;
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
                      if(role!)
                      sl<UserProfileProvider>().getUserFollowers(
                        id: userId!,
                      );

                      if (role != null) {
                        sl<UserProfileProvider>().getUserOffers(
                          id: userId!,
                          role: !role! ? "driver" : "client",
                        );
                      }
                      CustomNavigator.push(Routes.USER_PROFILE,
                          arguments: userId);
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
                              "$duration يوم ",
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
                      visible: followers != null,
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
                      visible: followers != null,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            customImageIconSVG(
                                imageName: SvgImages.addFollower),
                            const SizedBox(height: 4),
                            MarqueeWidget(
                              child: Text(
                                "$followers",
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
                      visible: followers == null,
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
                      visible: followers == null,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  createdAt == null
                      ? getTranslated("now", context)
                      : Methods.getDayCount(
                          date: createdAt!,
                        ).toString(),
                  style: AppTextStyles.w400.copyWith(fontSize: 10, height: 1),
                ),
                SizedBox(
                  height: 4.h,
                ),
                if (withAnalytics)
                  const AcceptableAnalytics(
                    value: 50,
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

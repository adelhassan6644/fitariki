import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:fitariki/features/user_profile/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/offer_card.dart';
import '../../../main_widgets/shimmer_widgets/profile_card_shimmer.dart';
import '../../more/widgets/profile_card.dart';
import '../../offer_details/widgets/car_details.dart';
import '../../profile/provider/profile_provider.dart';
import '../../wishlist/provider/wishlist_provider.dart';
import '../widgets/follower_distance_widget.dart';

class UserProfile extends StatefulWidget {
  final int userId;
  const UserProfile({required this.userId, Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => Provider.of<UserProfileProvider>(context, listen: false)
            .getUserProfile(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProfileProvider>(builder: (_, provider, child) {
        return Column(
          children: [
            Stack(
              children: [
                CustomAppBar(
                  withSave: true,
                  onSave: () {
                    if (sl<ProfileProvider>().isLogin) {
                      sl<WishlistProvider>()
                          .postWishList(userId: widget.userId);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: provider.isLoading
                      ? const ProfileCardShimmer()
                      : ProfileCard(
                          lastUpdate: Methods.getDayCount(
                                  date: !sl<ProfileProvider>().isDriver
                                      ? provider
                                          .userProfileModel!.driver!.updatedAt!
                                      : provider
                                          .userProfileModel!.client!.updatedAt!)
                              .toString(),
                          name: !sl<ProfileProvider>().isDriver
                              ? "${provider.userProfileModel!.driver!.firstName}"
                              : "${provider.userProfileModel!.client!.firstName} ${provider.userProfileModel!.client!.lastName}",
                          isDriver: !sl<ProfileProvider>().isDriver,
                          male: !sl<ProfileProvider>().isDriver
                              ? provider.userProfileModel!.driver!.gender == 0
                              : provider.userProfileModel!.client!.gender == 0,
                          nationality: !sl<ProfileProvider>().isDriver
                              ? provider.userProfileModel!.driver!.national
                                      ?.name ??
                                  ""
                              : provider.userProfileModel?.client?.national
                                      ?.name ??
                                  "",
                          rate: !sl<ProfileProvider>().isDriver
                              ? provider.userProfileModel?.driver?.rate?.ceil()
                              : provider.userProfileModel?.client?.rate?.ceil(),
                          completedNumber: 2,
                          offersNumber: 2,
                          distance: "2.5 كيلو",
                        ),
                )
              ],
            ),
            Expanded(
              child: ListAnimator(
                data: [
                  SizedBox(
                    height: 12.h,
                  ),
                  if (!sl<ProfileProvider>().isDriver)
                    CarDetails(
                      carInfo: provider.userProfileModel?.driver?.carInfo,
                    ),
                  if (sl<ProfileProvider>().isDriver)
                    const FollowerDistanceWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            sl.get<ProfileProvider>().isDriver
                                ? getTranslated("current_requests", context)
                                : getTranslated("current_offers", context),
                            style: AppTextStyles.w600.copyWith(fontSize: 16),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            getTranslated("view_all", context),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 11, color: ColorResources.DISABLED),
                          ),
                        )
                      ],
                    ),
                  ),
                  ...List.generate(
                      sl<HomeProvider>().offer?.length ?? 0,
                      (index) => OfferCard(
                          offerModel: sl<HomeProvider>().offer![index]))
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

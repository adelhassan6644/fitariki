import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/main_widgets/car_trip_details_widget.dart';
import 'package:fitariki/features/user_profile/provider/user_profile_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/reviews_widget.dart';
import '../../../main_widgets/shimmer_widgets/profile_card_shimmer.dart';
import '../../../navigation/routes.dart';
import '../../maps/provider/location_provider.dart';
import '../../more/widgets/profile_card.dart';
import '../widgets/follower_distance_widget.dart';
import '../widgets/user_offer_card.dart';

class UserProfile extends StatelessWidget {
  final int userId;
  const UserProfile({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Consumer<UserProfileProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              Stack(
                children: [
                  CustomAppBar(
                    isOffer: false,
                    savedItemId: userId,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: provider.isLoadProfile
                        ? const ProfileCardShimmer()
                        : ProfileCard(
                            lastUpdate: Methods.getDayCount(
                                    date: provider.userProfileModel?.driver !=
                                            null
                                        ? provider.userProfileModel!.driver!
                                            .updatedAt!
                                        : provider.userProfileModel!.client!
                                            .updatedAt!)
                                .toString(),
                            image: provider.userProfileModel!.driver != null
                                ? provider.userProfileModel!.driver!.image
                                : provider.userProfileModel!.client!.image,
                            name: provider.userProfileModel!.driver != null
                                ? "${provider.userProfileModel!.driver!.firstName}"
                                : "${provider.userProfileModel!.client!.firstName} ${provider.userProfileModel!.client!.lastName}",
                            phone: provider.userProfileModel!.driver != null
                                ? "${provider.userProfileModel!.driver!.phone}"
                                : "${provider.userProfileModel!.client!.phone}",
                            withPhone: false,
                            isDriver: provider.userProfileModel!.driver != null,
                            male: provider.userProfileModel!.driver != null
                                ? provider.userProfileModel!.driver!.gender == 0
                                : provider.userProfileModel!.client!.gender ==
                                    0,
                            nationality:
                                provider.userProfileModel!.driver != null
                                    ? provider.userProfileModel!.driver!
                                            .national?.name ??
                                        ""
                                    : provider.userProfileModel?.client
                                            ?.national?.name ??
                                        "",
                            rate: provider.userProfileModel!.driver != null
                                ? provider.userProfileModel?.driver?.rate
                                    ?.ceil()
                                : provider.userProfileModel?.client?.rate
                                    ?.ceil(),
                            reservationCount:
                                provider.userProfileModel!.driver != null
                                    ? provider.userProfileModel?.driver
                                        ?.reservationsCount
                                    : provider.userProfileModel?.client
                                        ?.reservationsCount,
                            requestsCount:
                                provider.userProfileModel!.driver != null
                                    ? provider
                                        .userProfileModel?.driver?.requestsCount
                                    : provider.userProfileModel?.client
                                        ?.requestsCount,
                            distance: "  ${Methods.calcDistance(
                              lat1: sl<LocationProvider>()
                                  .currentLocation!
                                  .latitude!,
                              long1: sl<LocationProvider>()
                                  .currentLocation!
                                  .longitude!,
                              lat2: provider.userProfileModel!.driver != null
                                  ? provider.userProfileModel?.driver
                                          ?.pickupLocation?.latitude ??
                                      "0"
                                  : provider.userProfileModel?.client
                                          ?.pickupLocation?.latitude ??
                                      "0",
                              long2: provider.userProfileModel!.driver != null
                                  ? provider.userProfileModel?.driver
                                          ?.pickupLocation?.longitude ??
                                      "0"
                                  : provider.userProfileModel?.client
                                          ?.pickupLocation?.longitude ??
                                      "0",
                            )} كيلو",
                          ),
                  )
                ],
              ),
              Expanded(
                child: ListAnimator(data: [
                  SizedBox(
                    height: 12.h,
                  ),
                  if (!provider.isDriver)
                    CarTripDetailsWidget(
                      isLoading: provider.isLoadProfile,
                      carInfo: provider.userProfileModel?.driver?.carInfo,
                    ),
                  if (provider.isDriver)
                    FollowerDistanceWidget(
                      isLoading: provider.isLoadFollowers,
                      followers: provider.userFollowers,
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            provider.isDriver
                                ? getTranslated("current_requests", context)
                                : getTranslated("current_offers", context),
                            style: AppTextStyles.w600.copyWith(fontSize: 16),
                          ),
                        ),
                        if (!provider.isLoadOffers &&
                            provider.userOffers != null &&
                            provider.userOffers?.offers != null &&
                            provider.userOffers!.offers!.length > 3)
                          InkWell(
                            onTap: () =>
                                CustomNavigator.push(Routes.ALL_USER_OFFERS),
                            child: Text(
                              getTranslated("view_all", context),
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 11, color: ColorResources.DISABLED),
                            ),
                          )
                      ],
                    ),
                  ),
                  if (provider.isLoadOffers)
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: 8.h),
                        child: CustomShimmerContainer(
                          height: 85.h,
                          radius: 8,
                        ),
                      ),
                    ),
                  if (provider.userOffers == null ||
                      provider.userOffers?.offers == null ||
                      provider.userOffers!.offers!.isEmpty)
                    Visibility(
                      visible: !provider.isLoadOffers,
                      child: EmptyState(
                          txt: provider.isDriver
                              ? getTranslated("there_is_no_offers_now", context)
                              : getTranslated(
                                  "there_is_no_requests_now", context)),
                    ),
                  if (!provider.isLoadOffers &&
                      provider.userOffers != null &&
                      provider.userOffers?.offers != null &&
                      provider.userOffers!.offers!.isNotEmpty)
                    ...List.generate(
                        provider.userOffers!.offers!.length > 5
                            ? 5
                            : provider.userOffers!.offers!.length,
                        (index) => UserOfferCard(
                            offerModel: provider.userOffers!.offers![index])),

                  SizedBox(
                    height: 8.h,
                  ),

                  // ReviewsWidget(
                  //   id: userId,
                  //   isOffer: false,
                  // ),
                ]),
              ),

            ],
          );
        }),
      ),
    );
  }
}

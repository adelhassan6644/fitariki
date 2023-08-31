import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/main_widgets/car_trip_details_widget.dart';
import 'package:fitariki/features/user_profile/provider/user_profile_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/empty_widget.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../main_widgets/shimmer_widgets/map_widget_shimmer.dart';
import '../../../main_widgets/shimmer_widgets/profile_card_shimmer.dart';
import '../../../main_widgets/week_days_widget.dart';
import '../../../navigation/routes.dart';
import '../../add_request/page/add_request.dart';
import '../../add_request/provider/add_request_provider.dart';
import '../../auth/pages/login.dart';
import '../../maps/provider/location_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/profile_card.dart';
import '../widgets/follower_distance_widget.dart';
import '../widgets/user_offer_card.dart';

class UserProfile extends StatefulWidget {
  final Map data;
  const UserProfile({required this.data, Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<UserProfileProvider>().getUserProfile(
          userId: widget.data["id"], myProfile: widget.data["my_profile"]);
      if ((sl<UserProfileProvider>().isDriver && !widget.data["my_profile"]) ||
          (widget.data["my_profile"] && !sl<UserProfileProvider>().isDriver)) {
        sl<UserProfileProvider>().getUserFollowers(
            id: widget.data["id"], myProfile: widget.data["my_profile"]);
      }
    });
    super.initState();
  }

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
                  Visibility(
                    visible: widget.data["my_profile"] != true,
                    child: CustomAppBar(
                      isOffer: false,
                      savedItemId:
                          provider.isLoadProfile ? null : widget.data["id"],
                      sepcailActionChild: Consumer<ProfileProvider>(
                          builder: (_, profileProvider, child) {
                        return Visibility(
                          visible: profileProvider.isLogin &&
                              !provider.isLoadProfile,
                          child: InkWell(
                            onTap: () {
                              if (profileProvider.isDriver &&
                                  profileProvider.status != "1") {
                                CustomSnackBar.showSnackBar(
                                    notification: AppNotification(
                                        message:
                                            "عفواً، لا يمكن اضافة عرض لانه لم يتم تفعيل حسابك بعد",
                                        isFloating: true,
                                        backgroundColor: Styles.IN_ACTIVE,
                                        borderColor: Colors.transparent));
                              } else {
                                customShowModelBottomSheet(
                                    onClose: () =>
                                        sl<AddRequestProvider>().reset(),
                                    body: profileProvider.isLogin
                                        ? AddRequest(
                                            name: provider.userProfileModel
                                                    ?.driver?.firstName ??
                                                provider.userProfileModel
                                                    ?.client?.firstName ??
                                                "",
                                            senderId: provider.userProfileModel
                                                    ?.driver?.id ??
                                                provider.userProfileModel
                                                    ?.client?.id,
                                            isSpecialOffer: true,
                                            isCaptain: provider.isDriver,
                                          )
                                        : const Login());
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                getTranslated("add_special_offer", context),
                                style: AppTextStyles.w400
                                    .copyWith(color: Styles.WHITE_COLOR),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: (!provider.isLoadProfile &&
                            provider.userProfileModel != null)
                        ? ProfileCard(
                            myProfile: widget.data["my_profile"],
                            lastUpdate: Methods.getDayCount(
                                    date: provider.userProfileModel?.driver
                                            ?.updatedAt ??
                                        provider.userProfileModel?.client
                                            ?.updatedAt ??
                                        DateTime.now())
                                .toString(),
                            image: provider.userProfileModel?.driver?.image ??
                                provider.userProfileModel?.client?.image ??
                                "",
                            name: provider
                                    .userProfileModel?.driver?.firstName ??
                                provider.userProfileModel?.client?.firstName ??
                                "",
                            isDriver: provider.userProfileModel?.driver != null,
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
                            distance: provider.userProfileModel!.driver != null
                                ? provider
                                    .userProfileModel?.driver?.pickupLocation
                                : provider
                                    .userProfileModel?.client?.pickupLocation,
                          )
                        : ProfileCardShimmer(
                            myProfile: widget.data["my_profile"]),
                  )
                ],
              ),
              Expanded(
                child: ListAnimator(data: [
                  ///Work Information
                  ExpansionTileWidget(
                    iconColor: Styles.SECOUND_PRIMARY_COLOR,
                    withTitlePadding: true,
                    title: getTranslated("work_information", context),
                    children: [
                      /// Selected Days in Week
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: WeekDaysWidget(
                          isLoading: provider.isLoadProfile &&
                              provider.userProfileModel == null,
                          days: provider.userProfileModel?.driver != null
                              ? provider.userProfileModel?.driver?.driverDays
                                  ?.map((e) => e.dayName ?? "")
                                  .toList()
                              : provider.userProfileModel?.client?.clientDays
                                  ?.map((e) => e.dayName ?? "")
                                  .toList(),
                          startTime: provider.userProfileModel?.driver != null
                              ? provider.userProfileModel!.driver!.driverDays
                                  ?.first.startTime
                              : provider.userProfileModel?.client?.clientDays
                                  ?.first.startTime,
                          endTime: provider.userProfileModel?.driver != null
                              ? provider.userProfileModel!.driver!.driverDays
                                  ?.first.endTime
                              : provider.userProfileModel?.client?.clientDays
                                  ?.first.endTime,
                        ),
                      ),

                      /// Map View
                      provider.isLoadProfile
                          ? const MapWidgetShimmer(withClientName: false)
                          : MapWidget(
                              launchMap: false,
                              showFullAddress: false,
                              startPoint: provider.userProfileModel?.driver
                                      ?.pickupLocation ??
                                  provider
                                      .userProfileModel?.client?.pickupLocation,
                              endPoint: provider.userProfileModel?.driver
                                      ?.dropOffLocation ??
                                  provider.userProfileModel?.client
                                      ?.dropOffLocation,
                            ),

                      ///Car Details
                      Visibility(
                        visible: (provider.isDriver ||
                            (!provider.isDriver && widget.data["my_profile"])),
                        child: FollowerDistanceWidget(
                          isLoading: provider.isLoadFollowers,
                          followers: provider.userFollowers,
                        ),
                      ),
                    ],
                  ),

                  ///Offers Head-title
                  Visibility(
                    visible: (!provider.isDriver &&
                            widget.data["my_profile"] == false) ||
                        (provider.isDriver &&
                            widget.data["my_profile"] == true),
                    child: CarTripDetailsWidget(
                      isLoading: provider.isLoadProfile,
                      carInfo: provider.userProfileModel?.driver?.carInfo,
                    ),
                  ),

                  ///Offers Head-title
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 16.h),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          (!provider.isDriver &&
                                      widget.data["my_profile"] == false) ||
                                  (provider.isDriver &&
                                      widget.data["my_profile"] == true)
                              ? getTranslated("current_offers", context)
                              : getTranslated("current_requests", context),
                          style: AppTextStyles.w600.copyWith(fontSize: 16),
                        )),
                        Visibility(
                          visible: (!provider.isLoadOffers &&
                              widget.data["my_profile"] == false &&
                              provider.userOffers != null &&
                              provider.userOffers?.offers != null &&
                              provider.userOffers!.offers!.length > 3),
                          child: InkWell(
                            onTap: () =>
                                CustomNavigator.push(Routes.ALL_USER_OFFERS),
                            child: Text(
                              getTranslated("view_all", context),
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 11, color: Styles.DISABLED),
                            ),
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

                  ///Offers Empty State
                  Visibility(
                    visible: !provider.isLoadOffers &&
                        (provider.userOffers == null ||
                            provider.userOffers?.offers == null ||
                            provider.userOffers!.offers!.isEmpty),
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
                            myProfile: widget.data["my_profile"],
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

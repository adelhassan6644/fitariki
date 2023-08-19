import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:fitariki/features/offer_details/repo/offer_details_repo.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/shimmer_widgets/offer_details_shimmer.dart';
import '../../../main_widgets/user_card.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../add_request/page/add_request.dart';
import '../../add_request/provider/add_request_provider.dart';
import '../../auth/pages/login.dart';
import '../provider/offer_details_provider.dart';
import '../widgets/car_details.dart';
import '../../../main_widgets/reviews_widget.dart';

class OfferDetails extends StatelessWidget {
  final int offerId;
  const OfferDetails({Key? key, required this.offerId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: ChangeNotifierProvider(
          create: (_) => OfferDetailsProvider(repo: sl<OfferDetailsRepo>())
            ..getOfferDetails(offerId: offerId),
          child: Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                CustomAppBar(
                  title: provider.isDriver
                      ? getTranslated("delivery_request", context)
                      : getTranslated("delivery_offer", context),
                  savedItemId: offerId,
                ),
                !provider.isLoading && provider.offerDetails != null
                    ? Expanded(
                        child: ListAnimator(
                          data: [
                            ///user card
                            Container(
                                color: Styles.APP_BAR_BACKGROUND_COLOR,
                                child: UserCard(
                                  userId: provider.isDriver
                                      ? provider.offerDetails?.clientId
                                      : provider.offerDetails?.driverId,
                                  image: provider.isDriver
                                      ? provider
                                          .offerDetails!.clientModel?.image
                                      : provider
                                          .offerDetails!.driverModel?.image,
                                  name: provider.isDriver
                                      ? "${provider.offerDetails!.clientModel?.firstName} ${provider.offerDetails!.clientModel?.lastName}"
                                      : provider
                                          .offerDetails!.driverModel?.firstName,
                                  male: provider.isDriver
                                      ? provider.offerDetails!.clientModel
                                              ?.gender ==
                                          0
                                      : provider.offerDetails!.driverModel
                                              ?.gender ==
                                          0,
                                  national: provider.isDriver
                                      ? provider.offerDetails!.clientModel
                                          ?.national?.niceName
                                      : provider.offerDetails!.driverModel
                                          ?.national?.niceName,
                                  createdAt: provider.offerDetails!.createdAt!,
                                  matching: provider.offerDetails?.matching,
                                  days: provider.offerDetails!.offerDays!
                                      .map((e) => e.dayName)
                                      .toList()
                                      .join(", "),
                                  duration: provider.offerDetails!.duration
                                      .toString(),
                                  rate: provider.isDriver
                                      ? provider.offerDetails!.clientModel?.rate
                                      : provider
                                          .offerDetails!.driverModel?.rate,
                                  priceRange:
                                      "${provider.offerDetails!.minPrice.toString()} : ${provider.offerDetails!.maxPrice.toString()} ريال",
                                  timeRange: provider
                                          .offerDetails!.offerDays!.isEmpty
                                      ? ""
                                      : "${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].endTime, withFormat: true)}",
                                )),

                            /// Map View
                            MapWidget(
                              launchMap: false,
                              stopPoints: provider.isDriver &&
                                      provider.offerDetails?.offerFollowers !=
                                          null &&
                                      provider.offerDetails!.offerFollowers!
                                          .isNotEmpty
                                  ? provider
                                      .offerDetails!.offerFollowers!.length
                                  : null,
                              startPoint: provider.offerDetails!.pickupLocation,
                              endPoint: provider.offerDetails!.dropOffLocation,
                            ),

                            ///distance between client and driver
                            DistanceWidget(
                              isCaptain: provider.isDriver,
                              lat1: sl<LocationProvider>()
                                  .currentLocation!
                                  .latitude!,
                              long1: sl<LocationProvider>()
                                  .currentLocation!
                                  .longitude!,
                              lat2: provider
                                      .offerDetails?.pickupLocation?.latitude ??
                                  "0",
                              long2: provider.offerDetails?.pickupLocation
                                      ?.longitude ??
                                  "0",
                            ),

                            /// to show stop points for followers of offer details if driver
                            Visibility(
                              visible: provider.isDriver &&
                                  provider.offerDetails?.offerFollowers !=
                                      null &&
                                  provider
                                      .offerDetails!.offerFollowers!.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w),
                                    child: Text(
                                      getTranslated("stop_points", context),
                                      style: AppTextStyles.w600.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    provider.offerDetails?.offerFollowers
                                            ?.length ??
                                        0,
                                    (index) => MapWidget(
                                      launchMap: false,
                                      clientName: provider.offerDetails
                                              ?.offerFollowers?[index].name ??
                                          "",
                                      gender: provider.offerDetails
                                          ?.offerFollowers?[index].gender,
                                      startPoint: provider
                                          .offerDetails
                                          ?.offerFollowers?[index]
                                          .pickupLocation,
                                      endPoint: provider
                                          .offerDetails
                                          ?.offerFollowers?[index]
                                          .dropOffLocation,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// to show car data if client
                            Visibility(
                              visible: !provider.isDriver,
                              child: CarDetails(
                                carInfo:
                                    provider.offerDetails?.driverModel?.carInfo,
                              ),
                            ),

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
                                  Text(
                                    provider.offerDetails?.rideType ?? "",
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: !provider.isDriver,
                              child: ReviewsWidget(
                                id: offerId,
                                isOffer: true,
                              ),
                            )
                          ],
                        ),
                      )
                    : OfferDetailsShimmer(
                        isDriver: provider.isDriver,
                      ),
                Visibility(
                  visible: !provider.isLoading,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 24.h),
                    child: CustomButton(
                        textColor: provider.offerDetails?.isSentOffer == true
                            ? Styles.PRIMARY_COLOR
                            : Styles.WHITE_COLOR,
                        backgroundColor:
                            provider.offerDetails?.isSentOffer == true
                                ? Styles.PRIMARY_COLOR.withOpacity(0.1)
                                : Styles.PRIMARY_COLOR,
                        text: provider.offerDetails?.isSentOffer == true
                            ? getTranslated(
                                provider.isDriver
                                    ? "offer_sent"
                                    : "request_sent",
                                context)
                            : getTranslated(
                                provider.isDriver ? "add_offer" : "add_request",
                                context),
                        onTap: () async {
                          if (provider.offerDetails?.isSentOffer != true) {
                            if (provider.isDriver &&
                                sl<ProfileProvider>().status != "1") {
                              CustomSnackBar.showSnackBar(
                                  notification: AppNotification(
                                      message:
                                          "عفواً، لا يمكن اضافة عرض لانه لم يتم تفعيل حسابك بعد",
                                      isFloating: true,
                                      backgroundColor: Styles.IN_ACTIVE,
                                      borderColor: Colors.transparent));

                              // showToast("عفواً، لا يمكن اضافة عرض لانه لم يتم تفعيل حسابك بعد");
                            } else {
                              customShowModelBottomSheet(
                                  onClose: () =>
                                      sl<AddRequestProvider>().reset(),
                                  body: provider.isLogin
                                      ? AddRequest(
                                          name:
                                              provider.offerDetails?.name ?? "",
                                          offer: provider.offerDetails!,
                                          isCaptain: provider.isDriver,
                                        )
                                      : const Login());
                            }
                          }
                        }),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:fitariki/main_widgets/user_card.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../main_widgets/shimmer_widgets/request_details_shimmer.dart';
import '../../maps/provider/location_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/request_details_provider.dart';
import '../widgets/car_trip_details_widget.dart';
import '../widgets/trip_days_on_calender_widget.dart';

class RequestDetails extends StatefulWidget {
  final int requestId;
  const RequestDetails({required this.requestId, Key? key}) : super(key: key);

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => sl<RequestDetailsProvider>()
            .getRequestDetails(id: widget.requestId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child:
              Consumer<RequestDetailsProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                CustomAppBar(
                  title: getTranslated("trip", context),
                ),
                provider.isLoading
                    ? RequestDetailsShimmer(
                        isDriver: provider.isDriver,
                      )
                    : Expanded(
                        child: ListAnimator(
                          data: [
                            ///user card
                            UserCard(
                              withAnalytics: false,
                              userId: provider.isDriver
                                  ? provider.requestModel?.clientId
                                  : provider.requestModel?.driverId,
                              name: provider.isDriver
                                  ? provider.requestModel?.clientModel?.firstName
                                  : provider.requestModel?.driverModel?.firstName,
                              isMale: provider.isDriver
                                  ? provider.requestModel?.clientModel?.gender == 0
                                  : provider.requestModel?.driverModel?.gender == 0,
                              national: provider.isDriver
                                  ? provider.requestModel?.clientModel?.national?.niceName
                                  : provider.requestModel?.driverModel?.national?.niceName,
                              createdAt: provider.requestModel?.createdAt ?? DateTime.now(),
                              days: provider.requestModel?.offer?.offerDays!.map((e) => e.dayName).toList().join(", "),
                              duration: provider.requestModel?.duration.toString(),
                              priceRange: "${provider.requestModel?.price ?? 0} ريال",
                              followers:provider.requestModel!.followers!.isNotEmpty? "${ provider.requestModel?.followers?.length}" : null,
                              timeRange: "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                            ),

                            ///client road map
                            MapWidget(
                                stopPoints: provider.isDriver &&
                                        provider.requestModel?.followers !=
                                            null &&
                                        provider
                                            .requestModel!.followers!.isNotEmpty
                                    ? provider
                                            .requestModel?.followers?.length ??
                                        0
                                    : null,
                                startPoint:
                                    provider.isDriver
                                        ? provider.requestModel?.clientModel
                                            ?.pickupLocation
                                        : provider.requestModel?.driverModel
                                            ?.pickupLocation,
                                endPoint: provider.isDriver
                                    ? provider.requestModel?.clientModel
                                        ?.dropOffLocation
                                    : provider.requestModel?.driverModel
                                        ?.dropOffLocation),

                            ///distance between client and driver
                            DistanceWidget(
                                isCaptain: provider.isDriver,
                                lat1: sl<LocationProvider>()
                                    .currentLocation!
                                    .latitude!,
                                long1: sl<LocationProvider>()
                                    .currentLocation!
                                    .longitude!,
                                lat2: provider.isDriver
                                    ? provider.requestModel?.clientModel
                                            ?.pickupLocation?.latitude ??
                                        "0"
                                    : provider.requestModel?.driverModel
                                            ?.pickupLocation?.latitude ??
                                        "0",
                                long2: provider.isDriver
                                    ? provider.requestModel?.clientModel
                                            ?.pickupLocation?.longitude ??
                                        "1"
                                    : provider.requestModel?.driverModel
                                            ?.pickupLocation?.longitude ??
                                        "1"),

                            /// to show stop points for followers request if driver
                            Visibility(
                              visible: provider.isDriver &&
                                  provider.requestModel?.followers != null &&
                                  provider.requestModel!.followers!.isNotEmpty,
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
                                    provider.requestModel?.followers?.length ?? 0,
                                    (index) => MapWidget(
                                      clientName: provider.requestModel
                                              ?.followers?[index].name ??
                                          "",
                                      gender: provider.requestModel
                                          ?.followers?[index].gender,
                                      startPoint: provider.requestModel
                                          ?.followers?[index].pickupLocation,
                                      endPoint: provider.requestModel
                                          ?.followers?[index].dropOffLocation,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// to show car data if client
                            Visibility(
                                visible: !provider.isDriver,
                                child: CarTripDetailsWidget(
                                  carInfo: provider
                                      .requestModel?.driverModel?.carInfo,
                                )),

                            /// to show days on calender
                            TripDaysOnCalenderWidget(
                                startDate: provider.requestModel?.startAt,
                                endDate: provider.requestModel?.endAt,
                                days: provider.isDriver
                                    ? provider.requestModel?.clientModel?.clientDays
                                    : provider.requestModel?.driverModel?.driverDays),

                            // ///to show notes
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 8.h,
                            //       horizontal:
                            //       Dimensions.PADDING_SIZE_DEFAULT.w),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               getTranslated("note", context),
                            //               style: AppTextStyles.w600
                            //                   .copyWith(fontSize: 10),
                            //             ),
                            //             Text(
                            //               "“ يوجد معي راكب بنفس حيك + نفس وجهتك “",
                            //               maxLines: 2,
                            //               style: AppTextStyles.w400.copyWith(
                            //                   fontSize: 10,
                            //                   overflow: TextOverflow.ellipsis),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 30.w,
                            //       )
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 24.h,
                            )
                          ],
                        ),
                      ),

                ///to update request
                Visibility(
                  visible: !provider.isLoading,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: 8.h),
                        child: CustomButton(
                          text: sl.get<ProfileProvider>().isDriver
                              ? getTranslated("accept_request", context)
                              : getTranslated("accept_offer", context),
                          onTap: () => provider.updateRequest(
                              status: 1, id: widget.requestId),
                          isLoading: provider.isAccepting,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: CustomButton(
                          text: getTranslated("negotiation", context),
                          backgroundColor: ColorResources.WHITE_COLOR,
                          withBorderColor: true,
                          textColor: ColorResources.PRIMARY_COLOR,
                          onTap: () => CupertinoPopUpHelper.showCupertinoTextController(
                                  title: getTranslated("negotiation", context),
                                  description: getTranslated(
                                      "negotiation_description", context),
                                  controller: provider.negotiationPrice,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  onSend: () {
                                    provider.updateRequest(
                                        status: 2, id: widget.requestId);
                                    CustomNavigator.pop();
                                  },
                                  onClose: () {
                                    provider.negotiationPrice.clear();
                                  }),
                          isLoading: provider.isNegotiation,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: CustomButton(
                          text: sl.get<ProfileProvider>().isDriver
                              ? getTranslated("reject_request", context)
                              : getTranslated("reject_offer", context),
                          backgroundColor: ColorResources.WHITE_COLOR,
                          withBorderColor: true,
                          textColor: ColorResources.PRIMARY_COLOR,
                          onTap: () => provider.updateRequest(
                              status: 3, id: widget.requestId),
                          isLoading: provider.isRejecting,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      )
                    ],
                  ),
                )
              ],
            );
          })),
    );
  }
}

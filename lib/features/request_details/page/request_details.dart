import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/main_widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../main_widgets/shimmer_widgets/request_details_shimmer.dart';
import '../provider/request_details_provider.dart';
import '../../../main_widgets/car_trip_details_widget.dart';
import '../widgets/action_buttons.dart';
import '../widgets/trip_days_on_calender_widget.dart';

class RequestDetails extends StatefulWidget {
  final int id;

  const RequestDetails({required this.id, Key? key}) : super(key: key);

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero,
        () => sl<RequestDetailsProvider>().getRequestDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("trip", context),
      ),
      body: SafeArea(child:
          Consumer<RequestDetailsProvider>(builder: (_, provider, child) {
        return Column(
          children: [
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
                          approved: provider.requestModel?.approvedAt != null &&
                              provider.requestModel?.paidAt != null,
                          reservationId: provider.requestModel?.id,
                          phone: provider.requestModel?.clientModel != null
                              ? provider.requestModel?.clientModel?.phone
                              : provider.requestModel?.driverModel?.phone,
                          userId: provider.requestModel?.clientId ??
                              provider.requestModel?.driverId,
                          name: provider.requestModel?.clientModel != null
                              ? "${provider.requestModel?.clientModel?.firstName ?? ""} ${provider.requestModel?.clientModel?.lastName ?? ""}"
                              : provider.requestModel?.driverModel?.firstName ??
                                  "",
                          image: provider.requestModel?.clientModel != null
                              ? provider.requestModel?.clientModel?.image
                              : provider.requestModel?.driverModel?.image,
                          male: provider.requestModel?.clientModel != null
                              ? provider.requestModel?.clientModel?.gender == 0
                              : provider.requestModel?.driverModel?.gender == 0,
                          national: provider.requestModel?.clientModel != null
                              ? provider
                                  .requestModel?.clientModel?.national?.niceName
                              : provider.requestModel?.driverModel?.national
                                  ?.niceName,
                          createdAt: provider.requestModel?.createdAt ??
                              DateTime.now(),
                          days: provider.requestModel?.offer?.offerDays!
                              .map((e) => e.dayName)
                              .toList()
                              .join(", "),
                          duration: provider.requestModel?.duration.toString(),
                          priceRange:
                              "${provider.requestModel?.price ?? 0} ${getTranslated("sar", context)}",
                          passengers: provider.requestModel?.followers !=
                                      null &&
                                  provider.requestModel!.followers!.isNotEmpty
                              ? provider.requestModel!.followers!.length + 1
                              : 1,
                          timeRange:
                              "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                        ),

                        ///Request Details
                        ExpansionTileWidget(
                          iconColor: Styles.SECOUND_PRIMARY_COLOR,
                          withTitlePadding: true,
                          title: getTranslated("details", context),
                          children: [
                            /// Map View
                            MapWidget(
                              launchMap: false,
                              stopPoints: provider.isDriver &&
                                      provider.requestModel?.followers !=
                                          null &&
                                      provider
                                          .requestModel!.followers!.isNotEmpty
                                  ? provider.requestModel?.followers?.length ??
                                      0
                                  : null,
                              startPoint: provider.isDriver
                                  ? provider.requestModel?.clientModel
                                          ?.pickupLocation ??
                                      provider.requestModel?.offer?.clientModel
                                          ?.pickupLocation
                                  : provider
                                      .requestModel?.offer?.pickupLocation,
                              endPoint: provider.isDriver
                                  ? provider.requestModel?.clientModel
                                      ?.dropOffLocation
                                  : provider
                                      .requestModel?.offer?.dropOffLocation,
                            ),

                            ///distance between client and driver
                            DistanceWidget(
                              isCaptain: provider.isDriver,
                              location: provider.isDriver
                                  ? provider
                                      .requestModel?.clientModel?.pickupLocation
                                  : provider
                                      .requestModel?.offer?.pickupLocation,
                            ),

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
                                    provider.requestModel?.followers?.length ??
                                        0,
                                    (index) => MapWidget(
                                      launchMap: false,
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

                            ///Type of ride
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
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
                                  const SizedBox(height: 8),
                                  Text(
                                    Methods.getOfferType(
                                        provider.requestModel?.offerType ??
                                            provider.requestModel?.offer
                                                ?.offerType ??
                                            1),
                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// to show car data if client
                        Visibility(
                            visible: !provider.isDriver,
                            child: CarTripDetailsWidget(
                              carInfo:
                                  provider.requestModel?.driverModel?.carInfo ??
                                      provider.requestModel?.offer?.driverModel
                                          ?.carInfo,
                            )),

                        /// to show days on calender
                        TripDaysOnCalenderWidget(
                          startDate: provider.requestModel?.startAt,
                          endDate: provider.requestModel?.endAt,
                          days: provider.requestModel?.offer?.offerDays,
                        ),

                        SizedBox(
                          height: 24.h,
                        )
                      ],
                    ),
                  ),

            ///to update request
            const ActionButtons()
          ],
        );
      })),
    );
  }
}

class RequestDetailsNavigationModel {
  final int requestId;
  final bool isFromMyTrips;
  RequestDetailsNavigationModel(
      {required this.requestId, required this.isFromMyTrips});
}

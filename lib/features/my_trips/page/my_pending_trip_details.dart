import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/main_widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/car_trip_details_widget.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../main_widgets/shimmer_widgets/request_details_shimmer.dart';
import '../../maps/provider/location_provider.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../../request_details/widgets/trip_days_on_calender_widget.dart';
import '../widgets/my_trip_details_action_button.dart';

class MyPendingTripDetails extends StatefulWidget {
  final int id;

  const MyPendingTripDetails({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<MyPendingTripDetails> createState() => _MyPendingTripDetailsState();
}

class _MyPendingTripDetailsState extends State<MyPendingTripDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero,
        () => sl<RequestDetailsProvider>().getRequestDetails(id: widget.id));
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
                              reservationId: provider.requestModel?.id,
                              phone: provider.isDriver
                                  ? provider.requestModel?.clientModel?.phone ??
                                      provider.requestModel?.offer?.clientModel
                                          ?.phone
                                  : provider.requestModel?.driverModel?.phone ??
                                      provider.requestModel?.offer?.driverModel
                                          ?.phone,
                              userId: provider.isDriver
                                  ? provider.requestModel?.clientModel?.id ??
                                      provider
                                          .requestModel?.offer?.clientModel?.id
                                  : provider.requestModel?.driverModel?.id ??
                                      provider
                                          .requestModel?.offer?.driverModel?.id,
                              name: provider.isDriver
                                  ? "${provider.requestModel?.clientModel?.firstName ?? provider.requestModel?.offer?.clientModel?.firstName ?? ""} ${provider.requestModel?.clientModel?.lastName ?? provider.requestModel?.offer?.clientModel?.lastName ?? ""}"
                                  : provider.requestModel?.driverModel
                                          ?.firstName ??
                                      provider.requestModel?.offer?.driverModel
                                          ?.firstName ??
                                      "",
                              image: provider.isDriver
                                  ? provider.requestModel?.clientModel?.image ??
                                      provider.requestModel?.offer?.clientModel
                                          ?.image
                                  : provider.requestModel?.driverModel?.image ??
                                      provider.requestModel?.offer?.driverModel
                                          ?.image,
                              male: provider.isDriver
                                  ? (provider.requestModel?.clientModel
                                              ?.gender ??
                                          provider.requestModel?.offer
                                              ?.clientModel?.gender) ==
                                      0
                                  : (provider.requestModel?.driverModel
                                              ?.gender ??
                                          provider.requestModel?.offer
                                              ?.driverModel?.gender) ==
                                      0,
                              national: provider.isDriver
                                  ? provider.requestModel?.clientModel?.national
                                          ?.niceName ??
                                      provider.requestModel?.offer?.clientModel
                                          ?.national?.niceName
                                  : provider.requestModel?.driverModel?.national
                                          ?.niceName ??
                                      provider.requestModel?.offer?.driverModel
                                          ?.national?.niceName,
                              createdAt: provider.requestModel?.createdAt ??
                                  DateTime.now(),
                              days: provider.requestModel?.offer?.offerDays!
                                  .map((e) => e.dayName)
                                  .toList()
                                  .join(", "),
                              duration:
                                  provider.requestModel?.duration.toString(),
                              priceRange:
                                  "${provider.requestModel?.price ?? 0} ${getTranslated("sar", context)}",
                              passengers: provider.requestModel?.followers !=
                                          null &&
                                      provider
                                          .requestModel!.followers!.isNotEmpty
                                  ? provider.requestModel!.followers!.length + 1
                                  : 1,
                              timeRange:
                                  "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                            ),

                            /// Map View
                            MapWidget(
                              stopPoints: provider.isDriver &&
                                      provider.requestModel?.followers !=
                                          null &&
                                      provider
                                          .requestModel!.followers!.isNotEmpty
                                  ? provider.requestModel?.followers?.length ??
                                      0
                                  : null,
                              startPoint: provider.isDriver
                                  ? provider.requestModel?.offer?.clientModel
                                      ?.dropOffLocation
                                  : provider
                                      .requestModel?.offer?.pickupLocation,
                              endPoint: provider.isDriver
                                  ? provider.requestModel?.offer?.clientModel
                                      ?.dropOffLocation
                                  : provider
                                      .requestModel?.offer?.dropOffLocation,
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
                                lat2: provider.isDriver
                                    ? provider.requestModel?.clientModel
                                            ?.pickupLocation?.latitude ??
                                        provider
                                            .requestModel
                                            ?.offer
                                            ?.clientModel
                                            ?.pickupLocation
                                            ?.latitude ??
                                        "0"
                                    : provider.requestModel?.offer?.pickupLocation?.latitude ??
                                        "0",
                                long2: provider.isDriver
                                    ? provider.requestModel?.clientModel
                                            ?.pickupLocation?.longitude ??
                                        provider
                                            .requestModel
                                            ?.offer
                                            ?.clientModel
                                            ?.pickupLocation
                                            ?.longitude ??
                                        "0"
                                    : provider.requestModel?.offer
                                            ?.pickupLocation?.longitude ??
                                        "0"),

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
                                  carInfo: provider.requestModel?.driverModel?.carInfo ??
                                      provider.requestModel?.offer?.driverModel?.carInfo,
                                )),

                            /// to show days on calender
                            TripDaysOnCalenderWidget(
                                startDate: provider.requestModel?.startAt,
                                endDate: provider.requestModel?.endAt,
                                days: provider.requestModel?.offer?.offerDays),

                            SizedBox(
                              height: 24.h,
                            )
                          ],
                        ),
                      ),

                ///to update request
                const MyTripDetailsActionButtons()
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

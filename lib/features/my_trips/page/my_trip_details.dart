import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/my_trips/model/my_trips_model.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:fitariki/main_widgets/user_card.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/car_trip_details_widget.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../maps/provider/location_provider.dart';
import '../../request_details/widgets/trip_days_on_calender_widget.dart';

class MyTripDetails extends StatelessWidget {
  final MyTripModel myTripModel;

  const MyTripDetails({
    required this.myTripModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              CustomAppBar(
                title: getTranslated("trip", context),
              ),
              Expanded(
                child: ListAnimator(
                  data: [
                    ///user card
                    UserCard(
                      withAnalytics: false,
                      approved: true,
                      reservationId: myTripModel.id,
                      phone: sl<ProfileProvider>().isDriver
                          ? myTripModel.offer?.clientModel?.phone??myTripModel.clientModel?.phone
                          : myTripModel.offer?.driverModel?.phone??myTripModel.driverModel?.phone,
                      userId: sl<ProfileProvider>().isDriver
                          ? myTripModel.offer?.clientModel?.id ??myTripModel.clientModel?.id
                          : myTripModel.offer?.driverModel?.id??myTripModel.driverModel?.id,
                      name: sl<ProfileProvider>().isDriver
                          ? "${myTripModel.offer?.clientModel?.firstName ??myTripModel.clientModel?.firstName?? ""} ${myTripModel.offer?.clientModel?.lastName??myTripModel.clientModel?.lastName ?? ""}"
                          : myTripModel.offer?.driverModel?.firstName??myTripModel.driverModel?.firstName ?? "",
                      image: sl<ProfileProvider>().isDriver
                          ? myTripModel.offer?.clientModel?.image??myTripModel.clientModel?.image
                          : myTripModel.offer?.driverModel?.image??myTripModel.driverModel?.image,
                      male: sl<ProfileProvider>().isDriver
                          ? (myTripModel.offer?.clientModel?.gender??myTripModel.clientModel?.gender )== 0
                          : (myTripModel.offer?.driverModel?.gender??myTripModel.driverModel?.gender) == 0,
                      national: sl<ProfileProvider>().isDriver
                          ? myTripModel.offer?.clientModel?.national?.niceName??myTripModel.clientModel?.national?.niceName
                          : myTripModel.offer?.driverModel?.national?.niceName??myTripModel.driverModel?.national?.niceName,
                      // createdAt: myTripModel.createAt ?? DateTime.now(),
                      days: myTripModel.offer?.offerDays!
                          .map((e) => e.dayName)
                          .toList()
                          .join(", "),
                      duration: myTripModel.myTripRequest?.duration.toString(),
                      // priceRange:
                      //     "${myTripModel.myTripRequest?.price ?? 0} ${getTranslated("sar", context)}",
                      passengers: myTripModel.myTripRequest?.followers !=
                                  null &&
                              myTripModel.myTripRequest!.followers!.isNotEmpty
                          ? myTripModel.myTripRequest!.followers!.length + 1
                          : 1,
                      timeRange: "${Methods.convertStringToTime(myTripModel.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(myTripModel.offer?.offerDays?[0].endTime, withFormat: true)}",
                    ),

                    /// Map View
                    MapWidget(
                      stopPoints: sl<ProfileProvider>().isDriver &&
                              myTripModel.myTripRequest?.followers != null &&
                              myTripModel.myTripRequest!.followers!.isNotEmpty
                          ? myTripModel.myTripRequest?.followers?.length ?? 0
                          : null,
                      startPoint: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.dropOffLocation
                          : myTripModel.myTripRequest?.offer?.pickupLocation,
                      endPoint: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.dropOffLocation
                          : myTripModel.myTripRequest?.offer?.dropOffLocation,
                    ),

                    ///distance between client and driver
                    DistanceWidget(
                        isCaptain: sl<ProfileProvider>().isDriver,
                        lat1: sl<LocationProvider>().currentLocation!.latitude!,
                        long1:
                            sl<LocationProvider>().currentLocation!.longitude!,
                        lat2: sl<ProfileProvider>().isDriver
                            ? myTripModel
                                    .clientModel?.pickupLocation?.latitude ??
                                "0"
                            : myTripModel.myTripRequest?.offer?.pickupLocation
                                    ?.latitude ??
                                "0",
                        long2: sl<ProfileProvider>().isDriver
                            ? myTripModel
                                    .clientModel?.pickupLocation?.longitude ??
                                "0"
                            : myTripModel.myTripRequest?.offer?.pickupLocation
                                    ?.longitude ??
                                "0"),

                    /// to show stop points for followers request if driver
                    Visibility(
                      visible: sl<ProfileProvider>().isDriver &&
                          myTripModel.myTripRequest?.followers != null &&
                          myTripModel.myTripRequest!.followers!.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                            child: Text(
                              getTranslated("stop_points", context),
                              style: AppTextStyles.w600.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ...List.generate(
                            myTripModel.myTripRequest?.followers?.length ?? 0,
                            (index) => MapWidget(
                              clientName: myTripModel
                                      .myTripRequest?.followers?[index].name ??
                                  "",
                              gender: myTripModel
                                  .myTripRequest?.followers?[index].gender,
                              startPoint: myTripModel.myTripRequest
                                  ?.followers?[index].pickupLocation,
                              endPoint: myTripModel.myTripRequest
                                  ?.followers?[index].dropOffLocation,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// to show car data if client
                    Visibility(
                        visible: !sl<ProfileProvider>().isDriver,
                        child: CarTripDetailsWidget(
                          carInfo: myTripModel.driverModel?.carInfo,
                        )),

                    /// to show days on calender
                    TripDaysOnCalenderWidget(
                        startDate: myTripModel.myTripRequest?.startAt,
                        endDate: myTripModel.myTripRequest?.endAt,
                        days: myTripModel.offer?.offerDays),

                    SizedBox(
                      height: 24.h,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

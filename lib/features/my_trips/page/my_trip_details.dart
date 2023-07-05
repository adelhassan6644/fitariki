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
                          ? myTripModel.clientModel?.phone ??
                              myTripModel.offer?.clientModel?.phone ??
                              myTripModel.myTripRequest?.clientModel?.phone
                          : myTripModel.driverModel?.phone ??
                              myTripModel.offer?.driverModel?.phone ??
                              myTripModel.myTripRequest?.driverModel?.phone,
                      userId: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.id ??
                              myTripModel.offer?.clientModel?.id ??
                              myTripModel.myTripRequest?.clientModel?.id
                          : myTripModel.driverModel?.id ??
                              myTripModel.offer?.driverModel?.id ??
                              myTripModel.myTripRequest?.driverModel?.id,
                      name: sl<ProfileProvider>().isDriver
                          ? "${myTripModel.clientModel?.firstName ?? myTripModel.offer?.clientModel?.firstName ?? myTripModel.myTripRequest?.clientModel?.firstName ?? ""} ${myTripModel.clientModel?.lastName ?? myTripModel.offer?.clientModel?.lastName ?? myTripModel.myTripRequest?.clientModel?.lastName ?? ""}"
                          : myTripModel.driverModel?.firstName ??
                              myTripModel.offer?.driverModel?.firstName ??
                              myTripModel
                                  .myTripRequest?.driverModel?.firstName ??
                              "",
                      image: sl<ProfileProvider>().isDriver
                          ? myTripModel.offer?.clientModel?.image ??
                              myTripModel.myTripRequest?.clientModel?.image ??
                              myTripModel.clientModel?.image
                          : myTripModel.offer?.driverModel?.image ??
                              myTripModel.myTripRequest?.driverModel?.image ??
                              myTripModel.driverModel?.image,
                      male: sl<ProfileProvider>().isDriver
                          ? (myTripModel.clientModel?.gender ??
                                  myTripModel.offer?.clientModel?.gender ??
                                  myTripModel
                                      .myTripRequest?.clientModel?.gender) ==
                              0
                          : (myTripModel.driverModel?.gender ??
                                  myTripModel.offer?.driverModel?.gender ??
                                  myTripModel
                                      .myTripRequest?.driverModel?.gender) ==
                              0,
                      national: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.national?.niceName ??
                              myTripModel
                                  .offer?.clientModel?.national?.niceName ??
                              myTripModel.myTripRequest?.clientModel?.national
                                  ?.niceName
                          : myTripModel.driverModel?.national?.niceName ??
                              myTripModel
                                  .offer?.driverModel?.national?.niceName ??
                              myTripModel.myTripRequest?.driverModel?.national
                                  ?.niceName,
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
                      timeRange:
                          "${Methods.convertStringToTime(myTripModel.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(myTripModel.offer?.offerDays?[0].endTime, withFormat: true)}",
                    ),

                    /// Map View
                    MapWidget(
                      stopPoints: sl<ProfileProvider>().isDriver &&
                              myTripModel.myTripRequest?.followers != null &&
                              myTripModel.myTripRequest!.followers!.isNotEmpty
                          ? myTripModel.myTripRequest?.followers?.length ?? 0
                          : null,
                      startPoint: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.pickupLocation ??
                              myTripModel.offer?.clientModel?.pickupLocation ??
                              myTripModel
                                  .myTripRequest?.clientModel?.pickupLocation
                          : myTripModel.offer?.pickupLocation,
                      endPoint: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.dropOffLocation ??
                              myTripModel.offer?.clientModel?.dropOffLocation ??
                              myTripModel
                                  .myTripRequest?.clientModel?.dropOffLocation
                          : myTripModel.offer?.dropOffLocation,
                    ),

                    ///distance between client and driver
                    DistanceWidget(
                      isCaptain: sl<ProfileProvider>().isDriver,
                      lat1: sl<LocationProvider>().currentLocation!.latitude!,
                      long1: sl<LocationProvider>().currentLocation!.longitude!,
                      lat2: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.pickupLocation?.latitude ??
                              myTripModel.offer?.clientModel?.pickupLocation?.latitude ??
                          myTripModel.myTripRequest?.clientModel?.pickupLocation?.latitude ?? "0"
                          : myTripModel.offer?.pickupLocation?.latitude ?? "0",
                      long2: sl<ProfileProvider>().isDriver
                          ? myTripModel.clientModel?.pickupLocation?.longitude ??
                              myTripModel.offer?.clientModel?.pickupLocation?.longitude ??
                              myTripModel.myTripRequest?.clientModel?.pickupLocation?.longitude ?? "0"
                          : myTripModel.offer?.pickupLocation?.longitude ?? "0",
                    ),

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
                          carInfo: myTripModel.driverModel?.carInfo ??
                              myTripModel.offer?.driverModel?.carInfo??
                              myTripModel.myTripRequest?.driverModel?.carInfo,
                        )),

                    /// to show days on calender
                    TripDaysOnCalenderWidget(
                        startDate: myTripModel.myTripRequest?.startAt,
                        endDate: myTripModel.myTripRequest?.endAt,
                        days: sl<ProfileProvider>().isDriver ?
                        myTripModel.clientModel?.clientDays ??
                            myTripModel.offer?.clientModel?.clientDays ??
                            myTripModel.myTripRequest?.clientModel?.clientDays
                            :  myTripModel.offer?.offerDays,
                      ),

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

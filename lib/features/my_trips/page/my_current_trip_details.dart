import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
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
import '../../request_details/widgets/trip_days_on_calender_widget.dart';
import '../provider/current_trip_details_provider.dart';
import '../repo/my_trips_repo.dart';

class MyCurrentTripDetails extends StatelessWidget {
  final int id;

  const MyCurrentTripDetails({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("trip", context),
        ),
        body: ChangeNotifierProvider(
          create: (_) => CurrentTripDetailsProvider(repo: sl<MyTripsRepo>())
            ..getCurrentTripDetails(id),
          child: Consumer<CurrentTripDetailsProvider>(
              builder: (_, provider, child) {
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
                              approved: true,
                              reservationId: provider.tripDetails?.id,
                              phone: provider.isDriver
                                  ? provider.tripDetails?.clientModel?.phone ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.phone ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.phone
                                  : provider.tripDetails?.driverModel?.phone ??
                                      provider.tripDetails?.offer?.driverModel
                                          ?.phone ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.phone,
                              userId: provider.isDriver
                                  ? provider.tripDetails?.clientModel?.id ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.id ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.id
                                  : provider.tripDetails?.driverModel?.id ??
                                      provider.tripDetails?.offer?.driverModel
                                          ?.id ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.id,
                              name: provider.isDriver
                                  ? "${provider.tripDetails?.clientModel?.firstName ?? provider.tripDetails?.offer?.clientModel?.firstName ?? provider.tripDetails?.myTripRequest?.clientModel?.firstName ?? ""} ${provider.tripDetails?.clientModel?.lastName ?? provider.tripDetails?.offer?.clientModel?.lastName ?? provider.tripDetails?.myTripRequest?.clientModel?.lastName ?? ""}"
                                  : provider.tripDetails?.driverModel
                                          ?.firstName ??
                                      provider.tripDetails?.offer?.driverModel
                                          ?.firstName ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.firstName ??
                                      "",
                              image: provider.isDriver
                                  ? provider
                                          .tripDetails?.offer?.clientModel?.image ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.image ??
                                      provider.tripDetails?.clientModel?.image
                                  : provider.tripDetails?.offer?.driverModel
                                          ?.image ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.image ??
                                      provider.tripDetails?.driverModel?.image,
                              male: sl<ProfileProvider>().isDriver
                                  ? (provider.tripDetails?.clientModel
                                              ?.gender ??
                                          provider.tripDetails?.offer
                                              ?.clientModel?.gender ??
                                          provider.tripDetails?.myTripRequest
                                              ?.clientModel?.gender) ==
                                      0
                                  : (provider.tripDetails?.driverModel
                                              ?.gender ??
                                          provider.tripDetails?.offer
                                              ?.driverModel?.gender ??
                                          provider.tripDetails?.myTripRequest
                                              ?.driverModel?.gender) ==
                                      0,
                              national: provider.isDriver
                                  ? provider.tripDetails?.clientModel?.national
                                          ?.niceName ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.national?.niceName ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.national?.niceName
                                  : provider.tripDetails?.driverModel?.national
                                          ?.niceName ??
                                      provider.tripDetails?.offer?.driverModel
                                          ?.national?.niceName ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.national?.niceName,
                              days:(provider.isDriver ?
                              provider.tripDetails?.clientModel?.clientDays ??
                                  provider.tripDetails?.offer?.clientModel?.clientDays ??
                                  provider.tripDetails?.myTripRequest?.clientModel?.clientDays
                                  : provider.tripDetails?.offer?.offerDays??[])!
                                  .map((e) => e.dayName)
                                  .toList()
                                  .join(", "),
                              duration: provider
                                  .tripDetails?.myTripRequest?.duration
                                  .toString(),
                              passengers: provider.tripDetails?.myTripRequest
                                              ?.followers !=
                                          null &&
                                      provider.tripDetails!.myTripRequest!
                                          .followers!.isNotEmpty
                                  ? provider.tripDetails!.myTripRequest!
                                          .followers!.length +
                                      1
                                  : 1,
                              timeRange:
                                  "${Methods.convertStringToTime(provider.tripDetails?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.tripDetails?.offer?.offerDays?[0].endTime, withFormat: true)}",
                            ),

                            /// Map View
                            MapWidget(
                              showFullAddress: true,
                              stopPoints: provider.isDriver &&
                                      provider.tripDetails?.myTripRequest
                                              ?.followers !=
                                          null &&
                                      provider.tripDetails!.myTripRequest!
                                          .followers!.isNotEmpty
                                  ? provider.tripDetails?.myTripRequest
                                          ?.followers?.length ??
                                      0
                                  : null,
                              startPoint: provider.isDriver
                                  ? provider.tripDetails?.clientModel
                                          ?.pickupLocation ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.pickupLocation ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.pickupLocation
                                  : provider.tripDetails?.offer?.pickupLocation,
                              endPoint: sl<ProfileProvider>().isDriver
                                  ? provider.tripDetails?.clientModel
                                          ?.dropOffLocation ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.dropOffLocation ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.dropOffLocation
                                  : provider
                                      .tripDetails?.offer?.dropOffLocation,
                            ),

                            ///distance between client and driver
                            DistanceWidget(
                              isCaptain: provider.isDriver,
                              location: provider.isDriver
                                  ? provider.tripDetails?.clientModel
                                          ?.pickupLocation ??
                                      provider.tripDetails?.offer?.clientModel
                                          ?.pickupLocation ??
                                      provider.tripDetails?.myTripRequest
                                          ?.clientModel?.pickupLocation
                                  : provider.tripDetails?.offer?.pickupLocation,
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
                                  const SizedBox(height: 8),
                                  Text(
                                    Methods.getOfferType(
                                        provider.tripDetails?.offerType ??
                                            provider.tripDetails?.myTripRequest
                                                ?.offerType ??
                                            provider.tripDetails?.offer
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

                            /// to show stop points for followers request if driver
                            Visibility(
                              visible: (provider.tripDetails?.myTripRequest
                                          ?.followers !=
                                      null &&
                                  provider.tripDetails!.myTripRequest!
                                      .followers!.isNotEmpty),
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
                                    provider.tripDetails?.myTripRequest
                                            ?.followers?.length ??
                                        0,
                                    (index) => MapWidget(
                                      showFullAddress: true,
                                      clientName: provider
                                              .tripDetails
                                              ?.myTripRequest
                                              ?.followers?[index]
                                              .name ??
                                          "",
                                      gender: provider
                                          .tripDetails
                                          ?.myTripRequest
                                          ?.followers?[index]
                                          .gender,
                                      startPoint: provider
                                          .tripDetails
                                          ?.myTripRequest
                                          ?.followers?[index]
                                          .pickupLocation,
                                      endPoint: provider
                                          .tripDetails
                                          ?.myTripRequest
                                          ?.followers?[index]
                                          .dropOffLocation,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: (provider
                                          .tripDetails?.offer?.offerFollowers !=
                                      null &&
                                  provider.tripDetails!.offer!.offerFollowers!
                                      .isNotEmpty),
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
                                    provider.tripDetails?.offer?.offerFollowers
                                            ?.length ??
                                        0,
                                    (index) => MapWidget(
                                      clientName: provider.tripDetails?.offer
                                              ?.offerFollowers?[index].name ??
                                          "",
                                      gender: provider.tripDetails?.offer
                                          ?.offerFollowers?[index].gender,
                                      startPoint: provider
                                          .tripDetails
                                          ?.offer
                                          ?.offerFollowers?[index]
                                          .pickupLocation,
                                      endPoint: provider
                                          .tripDetails
                                          ?.offer
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
                                child: CarTripDetailsWidget(
                                  showCarPlate: true,
                                  carInfo: provider
                                          .tripDetails?.driverModel?.carInfo ??
                                      provider.tripDetails?.offer?.driverModel
                                          ?.carInfo ??
                                      provider.tripDetails?.myTripRequest
                                          ?.driverModel?.carInfo,
                                )),

                            /// to show days on calender
                            TripDaysOnCalenderWidget(
                              startDate: provider.tripDetails?.myTripRequest?.startAt,
                              endDate: provider.tripDetails?.myTripRequest?.endAt,
                              days: provider.isDriver ?
                              provider.tripDetails?.clientModel?.clientDays ??
                                  provider.tripDetails?.offer?.clientModel?.clientDays ??
                                  provider.tripDetails?.myTripRequest?.clientModel?.clientDays
                                  : provider.tripDetails?.offer?.offerDays,
                            ),
                            // TripDaysOnCalenderWidget(
                            //   startDate: provider.tripDetails?.myTripRequest?.startAt,
                            //   endDate: provider.tripDetails?.myTripRequest?.endAt,
                            //   days: provider.tripDetails?.offer?.offerDays,
                            // ),

                            SizedBox(height: 24.h)
                          ],
                        ),
                      ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

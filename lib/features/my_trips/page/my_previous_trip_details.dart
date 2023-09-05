import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/address_pointer_widget.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/map_widget.dart';
import '../provider/previous_trip_details_provider.dart';
import '../repo/my_trips_repo.dart';

class MyTripDetails extends StatelessWidget {
  final int id;

  const MyTripDetails({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("trip_details", context),
        ),
        body: ChangeNotifierProvider(
          create: (_) => PreviousTripDetailsProvider(repo: sl<MyTripsRepo>())
            ..getPreviousTripDetails(id),
          child: Consumer<PreviousTripDetailsProvider>(
              builder: (_, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListAnimator(
                    data: [
                      /// Map View
                      MapWidget(
                        startPoint: provider.isDriver
                            ? provider
                                    .tripDetails?.clientModel?.pickupLocation ??
                                provider.tripDetails?.offer?.clientModel
                                    ?.pickupLocation ??
                                provider.tripDetails?.myTripRequest?.clientModel
                                    ?.pickupLocation
                            : provider.tripDetails?.offer?.pickupLocation,
                        endPoint: provider.isDriver
                            ? provider.tripDetails?.clientModel
                                    ?.dropOffLocation ??
                                provider.tripDetails?.offer?.clientModel
                                    ?.dropOffLocation ??
                                provider.tripDetails?.myTripRequest?.clientModel
                                    ?.dropOffLocation
                            : provider.tripDetails?.offer?.dropOffLocation,
                      ),

                      ///Pick up Location
                      AddressPointerWidget(
                        location: provider.isDriver
                            ? provider
                                    .tripDetails?.clientModel?.pickupLocation ??
                                provider.tripDetails?.offer?.clientModel
                                    ?.pickupLocation ??
                                provider.tripDetails?.myTripRequest?.clientModel
                                    ?.pickupLocation
                            : provider.tripDetails?.offer?.pickupLocation,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 4),
                        child: Container(
                          height: 12,
                          width: 2,
                          color: Styles.HINT_COLOR,
                        ),
                      ),

                      ///Followers Locations
                      Visibility(
                        visible: provider.tripDetails?.myTripRequest?.followers
                                ?.length !=
                            0,
                        child: Column(
                          children: List.generate(
                              provider.tripDetails?.myTripRequest?.followers
                                      ?.length ??
                                  0,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: index == 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 4),
                                          child: Container(
                                            height: 12,
                                            width: 2,
                                            color: Styles.HINT_COLOR,
                                          ),
                                        ),
                                      ),

                                      ///Pick up Location
                                      AddressPointerWidget(
                                        location: provider
                                            .tripDetails
                                            ?.myTripRequest
                                            ?.followers?[index]
                                            .pickupLocation,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 4),
                                        child: Container(
                                          height: 12,
                                          width: 2,
                                          color: Styles.HINT_COLOR,
                                        ),
                                      ),

                                      ///Drop off Location
                                      AddressPointerWidget(
                                        location: provider
                                            .tripDetails
                                            ?.myTripRequest
                                            ?.followers?[index]
                                            .dropOffLocation,
                                      ),
                                      Visibility(
                                        visible: index ==
                                            (provider.tripDetails?.myTripRequest
                                                        ?.followers?.length ??
                                                    0) -
                                                1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 4),
                                          child: Container(
                                            height: 12,
                                            width: 2,
                                            color: Styles.HINT_COLOR,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                        ),
                      ),

                      ///Drop off Location
                      AddressPointerWidget(
                        location: provider.isDriver
                            ? provider.tripDetails?.clientModel
                                    ?.dropOffLocation ??
                                provider.tripDetails?.offer?.clientModel
                                    ?.dropOffLocation ??
                                provider.tripDetails?.myTripRequest?.clientModel
                                    ?.dropOffLocation
                            : provider.tripDetails?.offer?.dropOffLocation,
                      ),

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

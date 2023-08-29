import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/maps/models/location_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/address_pointer_widget.dart';
import '../model/my_rides_model.dart';

class RideLocationsWidget extends StatelessWidget {
  const RideLocationsWidget(
      {super.key,
      required this.isDriver,
      this.pickLocation,
      this.dropOffLocation,
      required this.followerAddresses,
      this.status});
  final List<FollowerRideLocations> followerAddresses;
  final LocationModel? pickLocation;
  final LocationModel? dropOffLocation;
  final int? status;
  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Pick up Location
        AddressPointerWidget(
          location: pickLocation,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: Container(
            height: 12,
            width: 2,
            color: Styles.HINT_COLOR,
          ),
        ),

        ///Followers Locations
        Visibility(
          visible: followerAddresses.isNotEmpty,
          child: Column(
            children: List.generate(
                followerAddresses.length,
                (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          location: followerAddresses[index].pickupLocation,
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
                          location: followerAddresses[index].dropOffLocation,
                        ),
                        Visibility(
                          visible: index == followerAddresses.length - 1,
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
          location: dropOffLocation,
          trailer: getTranslated(
              (status == 0 || status == 1) ? "confirmed" : "absent", context),
          trailerColor: Styles.rideStatus(status),
        ),
      ],
    );
  }
}

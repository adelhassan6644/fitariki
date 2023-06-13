import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/my_trips_provider.dart';
import 'my_trip_card.dart';

class CurrentTripsWidget extends StatelessWidget {
  const CurrentTripsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTripsProvider>(builder: (_, provider, child) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            await provider.getCurrentTrips();
          },
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 4.h),
            physics: const AlwaysScrollableScrollPhysics(),
            children: provider.isGetCurrentTrips
                ? List.generate(
                    6,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0.h),
                          child: CustomShimmerContainer(
                            height: 95.h,
                            radius: 8,
                          ),
                        ))
                : !provider.isGetCurrentTrips &&
                        provider.currentTrips!.isNotEmpty
                    ? List.generate(
                        provider.currentTrips!.length,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h),
                              child: MyTripCard(
                                isCurrent: true,
                                isDriver: provider.isDriver,
                                offerPassengers: provider
                                        .currentTrips![index].offerPassengers ??
                                    1,
                                myTrip: provider.currentTrips![index],
                              ),
                            ))
                    : [
                        EmptyState(
                            txt: getTranslated("there_is_no_trips", context))
                      ],
          ),
        ),
      );
    });
  }
}

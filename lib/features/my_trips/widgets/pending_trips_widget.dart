import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/my_trips_provider.dart';
import 'my_trip_card.dart';

class PendingTripsWidget extends StatelessWidget {
  const PendingTripsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTripsProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 4.h),
        physics: const AlwaysScrollableScrollPhysics(),
        children: provider.isGetPendingTrips
            ? List.generate(
                6,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.h),
                      child: CustomShimmerContainer(
                        height: 95.h,
                        radius: 8,
                      ),
                    ))
            : !provider.isGetPendingTrips && provider.pendingTrips!.isNotEmpty
                ? List.generate(
                    provider.pendingTrips!.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0.h),
                          child: MyTripCard(
                            isPending: true,
                            myTrip: provider.pendingTrips![index],
                          ),
                        ))
                : [
                    EmptyState(txt: getTranslated("there_is_no_trips", context))
                  ],
      ));
    });
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/address_pointer_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../provider/previous_trip_details_provider.dart';
import '../repo/my_trips_repo.dart';
import '../widgets/invoice_details_widget.dart';
import '../widgets/previous_trip_user_widget.dart';
import '../widgets/shimmer/previous_trip_details_shimmer.dart';

class MyPreviousTripDetails extends StatelessWidget {
  final int id;

  const MyPreviousTripDetails({required this.id, Key? key}) : super(key: key);

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
                  child: provider.isLoading
                      ? PreviousTripDetailsShimmer(
                          isDriver: provider.isDriver,
                        )
                      : ListAnimator(
                          data: [
                            PreviousTripUserWidget(
                              userId: provider.isDriver
                                  ? provider.tripDetails?.client?.id
                                  : provider.tripDetails?.driver?.id,
                              image: provider.isDriver
                                  ? provider.tripDetails?.client?.image
                                  : provider.tripDetails?.driver?.image,
                              name: provider.isDriver
                                  ? provider.tripDetails?.client?.firstName
                                  : provider.tripDetails?.driver?.firstName
                                      ?.split(" ")
                                      .first,
                              rideType: provider.tripDetails?.type,
                              gender: provider.isDriver
                                  ? provider.tripDetails?.client?.gender == 0
                                  : provider.tripDetails?.driver?.gender == 0,
                              timeRange:
                                  "${Methods.convertStringToTime(provider.tripDetails?.days?[0].startTime, withFormat: true)} : ${Methods.convertStringToTime(provider.tripDetails?.days?[0].endTime, withFormat: true)}",
                              startDate: provider.tripDetails?.startDate,
                            ),

                            /// Map View
                            MapWidget(
                              showAddress: false,
                              startPoint: provider.tripDetails?.pickupLocation,
                              endPoint: provider.tripDetails?.dropOffLocation,
                            ),

                            ///Location
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///Pick up Location
                                  AddressPointerWidget(
                                    location:
                                        provider.tripDetails?.pickupLocation,
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
                                    location:
                                        provider.tripDetails?.dropOffLocation,
                                  ),
                                ],
                              ),
                            ),

                            ///PaymentDetails
                            const InvoiceDetailsWidget(),
                          ],
                        ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

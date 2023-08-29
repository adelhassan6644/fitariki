import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/tracking/widget/rider_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../../my_rides/widgets/ride_locations_widget.dart';
import '../provider/ride_details_provider.dart';
import '../repo/ride_details_repo.dart';
import 'car_details_widget.dart';

class RideDetailsWidget extends StatelessWidget {
  const RideDetailsWidget({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RideDetailsProvider(repo: sl<RideDetailsRepo>())..getRides(),
      child: Container(
          height: 400.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.WHITE_COLOR,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 5.0,
                    spreadRadius: -1,
                    offset: const Offset(0, 6))
              ]),
          child: Consumer<RideDetailsProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Styles.BORDER_COLOR,
                      ),
                    ),
                  ),
                ),
                const CarDetailsWidget(),
                RiderDetailsWidget(
                  image: provider.ride?.driver?.image ??
                      provider.ride?.client?.image ??
                      "",
                  name: provider.ride?.driver?.firstName ??
                      provider.ride?.client?.firstName ??
                      "",
                  phone: provider.ride?.driver?.phone ??
                      provider.ride?.client?.phone ??
                      "",
                  whatsApp: provider.ride?.driver?.phone ??
                      provider.ride?.client?.phone ??
                      "",
                  isDriver: provider.isDriver,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: RideLocationsWidget(
                    followerAddresses: provider.ride!.followersLocations!,
                    pickLocation: provider.ride!.pickupLocation,
                    dropOffLocation: provider.ride!.dropOffLocation,
                    isDriver: provider.isDriver,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Visibility(
                  visible: !provider.isDriver,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 24.h),
                    child: CustomButton(
                      text: getTranslated(
                          _buttonText(provider.ride!.status! + 1), context),
                      onTap:
                          provider.changeStatus(id, provider.ride!.status! + 1),
                      isLoading: provider.isChanging,
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }

  _buttonText(status) {
    switch (status) {
      case 0:
        return "waiting";
      case 1:
        return "ont_the_way";
      case 2:
        return "arrive";
      case 3:
        return "start_ride";
      case 4:
        return "end_ride";
    }
  }
}

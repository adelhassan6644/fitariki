import 'package:fitariki/app/core/utils/app_snack_bar.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/my_rides/model/my_rides_model.dart';
import 'package:fitariki/features/my_rides/widgets/ride_locations_widget.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../navigation/routes.dart';
import 'cancel_ride_pop_up_button.dart';

class RideCard extends StatelessWidget {
  const RideCard(
      {Key? key,
      required this.ride,
      required this.isDriver,
      required this.selectedDay})
      : super(key: key);
  final MyRideModel ride;
  final bool isDriver;
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8),
      child: InkWell(
        onTap: () {
          if (ride.status != 3 && ride.status != 4) {
            if (selectedDay.day == DateTime.now().day &&
                selectedDay.month == DateTime.now().month) {
              CustomNavigator.push(Routes.TRACKING, arguments: ride);
            } else {
              showToast(getTranslated("ride_not_started", context).replaceAll(
                  "**", selectedDay.dateFormat(format: "d MMM yyyy")));
            }
          } else {
            showToast(getTranslated("your_ride_is_ended", context));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
              color: Styles.WHITE_COLOR,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54.withOpacity(0.2),
                    blurRadius: 7.0,
                    spreadRadius: -1,
                    offset: const Offset(0, 2))
              ],
              gradient: LinearGradient(
                  colors: [Styles.WHITE_COLOR, Styles.rideStatus(ride.status)],
                  stops: const [0.98, 0.98])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "#_مشوارـ${ride.number}",
                      style: AppTextStyles.w600.copyWith(
                          fontSize: 14, color: Styles.rideStatus(ride.status)),
                    ),
                  ),
                  Visibility(
                    visible: ride.status == null,
                    child: CancelPopUpButton(
                      id: ride.id ?? 0,
                      number: ride.number ?? 0,
                      name: isDriver
                          ? ride.client?.firstName ?? ""
                          : ride.driver?.firstName ?? "",
                      day: ride.date ?? DateTime.now(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              RichText(
                text: TextSpan(
                    text: getTranslated("vehicle_arrival_approx", context),
                    style: AppTextStyles.w400.copyWith(
                        fontSize: 11, color: Styles.SECOUND_PRIMARY_COLOR),
                    children: [
                      TextSpan(
                        text: "  ${ride.time ?? ""}",
                        style: AppTextStyles.w700.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                      )
                    ]),
              ),
              const SizedBox(height: 12),
              RideLocationsWidget(
                followerAddresses: ride.followersLocations!,
                pickLocation: ride.pickupLocation,
                dropOffLocation: ride.dropOffLocation,
                status: ride.status,
                isDriver: isDriver,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

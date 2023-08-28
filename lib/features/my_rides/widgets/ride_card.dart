import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/my_rides/model/my_rides_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/address_pointer_widget.dart';
import 'cancel_ride_pop_up_button.dart';

class RideCard extends StatelessWidget {
  const RideCard({Key? key, required this.ride}) : super(key: key);
  final MyRideModel ride;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8),
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
            gradient: LinearGradient(colors: [
              Styles.WHITE_COLOR,
              (ride.cancelByClient! || ride.cancelByDriver!)
                  ? Styles.PENDING
                  : Styles.ACTIVE
            ], stops: const [
              0.98,
              0.98
            ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "#_مشوارـ${ride.number}",
                          style: AppTextStyles.w600
                              .copyWith(fontSize: 14, color: Styles.ACTIVE),
                        ),
                      ),
                      Visibility(
                        visible:
                            (!ride.cancelByClient! || !ride.cancelByDriver!),
                        child: CancelPopUpButton(
                          id: ride.id ?? 0,
                          number: ride.number ?? 0,
                          name: ride.name ?? "name",
                          startAt: ride.startedAt!,
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
                            text:
                                "  ${ride.arrivedAt?.dateFormat(format: "hh:mm a")}",
                            style: AppTextStyles.w700.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AddressPointerWidget(
                    address: const [
                      "طريق بدون اسم، مطار.shgwsgwsgtwsgtwsggewswsgwws..٤",
                      "طريق بدون اسم، مطار.shgwsgwsgtwsgtwsggewswsgwws..٤",
                    ],
                    isCancel: (ride.cancelByClient! || ride.cancelByDriver!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

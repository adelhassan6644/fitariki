import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../maps/models/location_model.dart';
import '../../profile/model/driver_model.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget(
      {super.key,
      required this.arriveAt,
      this.pickLocation,
      this.status,
      required this.isDriver,
      this.carInfo});

  final DateTime arriveAt;
  final LocationModel? pickLocation;
  final int? status;
  final bool isDriver;
  final CarInfo? carInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: status == null || (!isDriver && status == 0),
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: getTranslated("vehicle_arrival_approx", context),
                    style: AppTextStyles.w700.copyWith(
                        fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
                    children: [
                      TextSpan(
                        text:
                            "  ${arriveAt.dateFormat(format: "hh:mm a", lang: "en")}",
                        style: AppTextStyles.w700.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                      )
                    ]),
              ),
            ),
          ),

          Center(
            child: Visibility(
              visible: status != null && status != 0 && !isDriver,
              child: Text(
                getTranslated(titleText(status, isDriver), context),
                style: AppTextStyles.w700.copyWith(
                    fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          ///To show Car Data For Client
          Visibility(
              visible: !isDriver,
              child: Wrap(
                runSpacing: 5,
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Styles.LIGHT_GREY_BORDER,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      carInfo?.palletNumber ?? "",
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
                    ),
                  ),
                  Text(
                    "${carInfo?.name ?? ""} ,${carInfo?.color ?? ""}",
                    style: AppTextStyles.w400.copyWith(
                        fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  titleText(status, isDriver) {
    if (isDriver) {
      if (status == 1) {
        return "waiting_the_client";
      } else {
        return "go_to_destination";
      }
    } else {
      if (status == 1) {
        return "captain_arrived";
      } else {
        return "go_to_destination";
      }
    }
  }
}

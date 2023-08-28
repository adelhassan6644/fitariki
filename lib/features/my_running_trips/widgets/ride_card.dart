import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import 'cancel_ride_pop_up_button.dart';

class RideCard extends StatelessWidget {
  const RideCard({Key? key, required this.status}) : super(key: key);
  final String status;

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
              status == "confirmed" ? Styles.ACTIVE : Styles.PENDING
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
                          "#_مشوارـ٤",
                          style: AppTextStyles.w600
                              .copyWith(fontSize: 14, color: Styles.ACTIVE),
                        ),
                      ),
                      const CancelPopUpButton()
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
                                "  ${DateTime.now().dateFormat(format: "hh:mm a")}",
                            style: AppTextStyles.w700.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const _AddressWidget(
                    address:
                        "طريق بدون اسم، مطار.shgwsgwsgtwsgtwsggewswsgwws..٤",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Container(
                      height: 12,
                      width: 2,
                      color: Styles.HINT_COLOR,
                    ),
                  ),
                  _AddressWidget(
                    address:
                        "طريق بدون اسم، مطار.shgwsgwsgtwsgtwsggewswsgwws..٤",
                    status: getTranslated(status, context),
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

class _AddressWidget extends StatelessWidget {
  const _AddressWidget({super.key, required this.address, this.status});
  final String address;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customImageIconSVG(imageName: SvgImages.dotIcon, width: 10, height: 10),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            address,
            style: AppTextStyles.w400.copyWith(
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
                height: 1.4,
                color: Styles.DISABLED),
          ),
        ),
        const SizedBox(width: 8),
        status != null
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: status == "confirmed"
                      ? Styles.ACTIVE.withOpacity(0.1)
                      : Styles.PENDING.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status ?? "",
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 10,
                      color: status == "confirmed"
                          ? Styles.ACTIVE
                          : Styles.PENDING),
                ),
              )
            : const SizedBox(
                width: 35,
              ),
      ],
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';

class HomeCurrentTripWidget extends StatelessWidget {
  const HomeCurrentTripWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 0,
          Dimensions.PADDING_SIZE_DEFAULT, 14),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                colors: [Color(0xFFE8FFEF), Color(0xFFE8FFEF)],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.homeCalendar, width: 20, height: 20),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslated("running_trips", context),
                      style: AppTextStyles.w600
                          .copyWith(fontSize: 14, color: Colors.black)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      getTranslated("monitor_your_rides_in_one_place", context),
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 10, color: Styles.DISABLED)),
                ],
              )),
              const SizedBox(
                width: 16,
              ),
              customImageIconSVG(
                  imageName: SvgImages.runningTrips, width: 30, height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

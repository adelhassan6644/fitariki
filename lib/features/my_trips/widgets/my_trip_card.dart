import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/marquee_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../feedback/page/rate_trip.dart';
import '../model/my_trips_model.dart';

class MyTripCard extends StatelessWidget {
  const MyTripCard(
      {required this.myTrip,
      this.isCurrent = false,
      this.isPrevious = false,
      required this.isDriver,
      this.offerPassengers,
      Key? key})
      : super(key: key);
  final MyTripModel myTrip;
  final int? offerPassengers;
  final bool isCurrent, isPrevious, isDriver;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isCurrent) {
          CustomNavigator.push(Routes.MY_TRIP_DETAILS, arguments: myTrip);
        } else {}
      },
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.2),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage.circleNewWorkImage(
                            image: isDriver
                                ? myTrip.clientModel?.image ?? ""
                                : myTrip.driverModel?.image ?? "",
                            radius: 16,
                            color: ColorResources.SECOUND_PRIMARY_COLOR),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    isDriver
                                        ? "${myTrip.clientModel?.firstName ?? ""} ${myTrip.clientModel?.lastName ?? ""} "
                                        : myTrip.driverModel?.firstName ?? "",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: AppTextStyles.w600.copyWith(
                                        fontSize: 14,
                                        height: 1.25,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                customImageIconSVG(
                                    imageName: isDriver
                                        ? myTrip.clientModel?.gender == 0
                                            ? SvgImages.maleIcon
                                            : SvgImages.femaleIcon
                                        : myTrip.driverModel?.gender == 0
                                            ? SvgImages.maleIcon
                                            : SvgImages.femaleIcon,
                                    color: ColorResources.BLUE_COLOR,
                                    width: 11,
                                    height: 11)
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                isDriver
                                    ? myTrip.clientModel?.national?.niceName ??
                                        ""
                                    : myTrip.driverModel?.national?.niceName ??
                                        "",
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    height: 1.25,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: isCurrent ? 7 : 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${getTranslated("start_date", context)} ${myTrip.myTripRequest!.startAt!.dateFormat(format: "yyyy MMM d")}",
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  color: ColorResources.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isCurrent)
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                customImageIconSVG(
                                    imageName: SvgImages.roadLine),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: MarqueeWidget(
                                    child: Text(
                                      "${myTrip.myTripRequest!.duration} ${getTranslated("day", context)}",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    color: ColorResources.HINT_COLOR,
                                    height: 10,
                                    width: 1,
                                    child: const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (!isCurrent)
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                customImageIconSVG(imageName: SvgImages.wallet),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: MarqueeWidget(
                                    child: Text(
                                      "${myTrip.myTripRequest?.price} ${getTranslated("sar", context)}",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isCurrent)
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                customImageIconSVG(
                                    imageName: SvgImages.userNumber),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: MarqueeWidget(
                                    child: Text(
                                      "${offerPassengers ?? 1}",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                Row(
                  children: [
                    customImageIconSVG(
                      imageName: SvgImages.down,
                    ),
                    Text(
                      "${myTrip.myTripRequest?.price ?? 0}",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w700.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              if (isPrevious)
                GestureDetector(
                  onTap: () {
                    CustomNavigator.push(Routes.RATE_TRIP,
                        arguments: RateUserNavigationModel(
                            isDriver: isDriver,
                            name: isDriver
                                ? "${myTrip.clientModel?.firstName ?? ""} ${myTrip.clientModel?.firstName ?? ""}"
                                : myTrip.driverModel?.firstName ?? "",
                            userId:
                                isDriver ? myTrip.clientId : myTrip.driverId,
                            offerId: myTrip.offerId));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                    decoration: BoxDecoration(
                        color: ColorResources.PRIMARY_COLOR.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      getTranslated("rate", context),
                      style: AppTextStyles.w600.copyWith(
                          fontSize: 12, color: ColorResources.PRIMARY_COLOR),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

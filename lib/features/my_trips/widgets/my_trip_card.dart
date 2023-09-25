import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/marquee_widget.dart';
import '../../../main_models/weak_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../model/my_trips_model.dart';

class MyTripCard extends StatelessWidget {
  const MyTripCard(
      {required this.myTrip,
      required this.isCurrent,
      required this.isDriver,
      this.offerDays,
      this.offerPassengers,
      Key? key})
      : super(key: key);
  final MyTripModel myTrip;
  final int? offerPassengers;
  final bool isCurrent, isDriver;
  final List<WeekModel>? offerDays;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(
          isCurrent
              ? Routes.MY_CURRENT_TRIP_DETAILS
              : Routes.MY_PREVIOUS_TRIP_DETAILS,
          arguments: myTrip.id),
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h),
        child: Container(
          padding: const EdgeInsets.all(16),
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
                                ? myTrip.offer?.clientModel?.image ??
                                    myTrip.clientModel?.image ??
                                    ""
                                : myTrip.offer?.driverModel?.image ??
                                    myTrip.driverModel?.image ??
                                    "",
                            radius: 16,
                            color: Styles.SECOUND_PRIMARY_COLOR),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    isDriver
                                        ? myTrip.clientModel?.firstName ??
                                            myTrip.offer?.clientModel
                                                ?.firstName ??
                                            ""
                                        : myTrip.driverModel?.firstName
                                                ?.split(" ")[0] ??
                                            myTrip.offer?.driverModel?.firstName
                                                ?.split(" ")[0] ??
                                            "",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: AppTextStyles.w600.copyWith(
                                        fontSize: 14,
                                        height: 1.25,
                                        overflow: TextOverflow.ellipsis),
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
                                      color: Styles.BLUE_COLOR,
                                      width: 11,
                                      height: 11)
                                ],
                              ),
                              Text(
                                isDriver
                                    ? myTrip.clientModel?.national?.niceName ??
                                        myTrip.offer?.clientModel?.national
                                            ?.niceName ??
                                        ""
                                    : myTrip.driverModel?.national?.niceName ??
                                        myTrip.offer?.driverModel?.national
                                            ?.niceName ??
                                        "",
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    height: 1.25,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        ///to date of trip
                        Expanded(
                          flex: isCurrent ? 12 : 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    isCurrent
                                        ? "${getTranslated("start_date", context)} ${myTrip.myTripRequest!.startAt!.dateFormat(format: "yyyy MMM d")}"
                                        : "${getTranslated("end_date", context)} ${myTrip.myTripRequest!.endAt!.dateFormat(format: "yyyy MMM d")}",
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
                                  color: Styles.HINT_COLOR,
                                  height: 10,
                                  width: 1,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///to show number of passengers
                        Visibility(
                          visible: isCurrent,
                          child: Expanded(
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
                        ),

                        ///to duration of trip
                        Visibility(
                          visible: !isCurrent,
                          child: Expanded(
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
                                    color: Styles.HINT_COLOR,
                                    height: 10,
                                    width: 1,
                                    child: const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///to price of trip
                        Visibility(
                          visible: !isCurrent,
                          child: Expanded(
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
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !isCurrent,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.push(
                                Routes.USER_PROFILE,
                                arguments: {
                                  "id": isDriver
                                      ? myTrip.clientId
                                      : myTrip.driverId,
                                  "my_profile": false
                                }),
                            child: Text(
                              getTranslated(
                                  isDriver
                                      ? "explore_new_requests_with_this_client"
                                      : "explore_new_offers_with_this_captain",
                                  context),
                              style: AppTextStyles.w600.copyWith(
                                  fontSize: 12, color: Styles.PRIMARY_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Visibility(
                visible: isCurrent,
                child: Row(
                  children: [
                    customImageIconSVG(
                      imageName: SvgImages.down,
                    ),
                    Text(
                      "${Methods.getWeekdayCount(startDate: DateTime.now(), endDate: myTrip.myTripRequest?.endAt ?? DateTime.now(), weekdays: offerDays!.map((e) => e.id).toList()).count}",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w700.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

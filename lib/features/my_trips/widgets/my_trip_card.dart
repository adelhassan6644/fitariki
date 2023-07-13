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
import '../../../data/config/di.dart';
import '../../../main_models/weak_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../feedback/page/rate_trip.dart';
import '../../user_profile/provider/user_profile_provider.dart';
import '../model/my_trips_model.dart';

class MyTripCard extends StatelessWidget {
  const MyTripCard(
      {required this.myTrip,
      this.isCurrent = false,
      this.isPrevious = false,
      required this.isDriver,
       this.offerDays,
      this.offerPassengers,
      Key? key})
      : super(key: key);
  final MyTripModel myTrip;
  final int? offerPassengers;
  final bool isCurrent, isPrevious, isDriver;
  final  List<WeekModel>? offerDays;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isCurrent) {
          CustomNavigator.push(Routes.MY_TRIP_DETAILS, arguments: myTrip);
        }
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
                                ? myTrip.offer?.clientModel?.image?? myTrip.clientModel?.image  ?? ""
                                : myTrip.offer?.driverModel?.image ??myTrip.driverModel?.image ?? "",
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
                                  width: 80,
                                  child: Text(
                                    isDriver
                                        ? "${myTrip.clientModel?.firstName?? myTrip.offer?.clientModel?.firstName  ?? ""} ${myTrip.clientModel?.lastName??myTrip.offer?.clientModel?.lastName ?? ""} "
                                        : myTrip.driverModel?.firstName??myTrip.offer?.driverModel?.firstName ?? "",
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
                                    ? myTrip.clientModel?.national?.niceName ??myTrip.offer?.clientModel?.national?.niceName??
                                        ""
                                    : myTrip.driverModel?.national?.niceName ??myTrip.offer?.driverModel?.national?.niceName??
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
                        ///to start date of trip
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
                                  color: ColorResources.HINT_COLOR,
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
                          visible: isPrevious,
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
                                    color: ColorResources.HINT_COLOR,
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
                          visible: isPrevious,
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
                      visible: isPrevious,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () {
                              sl<UserProfileProvider>().getUserProfile(
                                  userId: isDriver
                                      ? myTrip.clientId!
                                      : myTrip.driverId!);


                              if (isDriver) {
                                sl<UserProfileProvider>().getUserFollowers(
                                    id: isDriver
                                        ? myTrip.clientId!
                                        : myTrip.driverId!);
                              }

                              CustomNavigator.push(Routes.USER_PROFILE,
                                  arguments: isDriver
                                      ? myTrip.clientId
                                      : myTrip.driverId);
                            },
                            child: Text(
                              getTranslated(
                                  isDriver
                                      ? "explore_new_requests_with_this_client"
                                      : "explore_new_offers_with_this_captain",
                                  context),
                              style: AppTextStyles.w600.copyWith(
                                  fontSize: 12,
                                  color: ColorResources.PRIMARY_COLOR),
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
              if (isCurrent)
                Row(
                  children: [
                    customImageIconSVG(
                      imageName: SvgImages.down,
                    ),
                    Text(
                      "${Methods.getWeekdayCount(
                          startDate: DateTime.now(),
                          endDate: myTrip.myTripRequest?.endAt??DateTime.now(),
                          weekdays: offerDays!.map((e) => e.id).toList()).count}",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w700.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    // Text(
                    //   "${myTrip.myTripRequest?.price ?? 0}",
                    //   textAlign: TextAlign.start,
                    //   style: AppTextStyles.w700.copyWith(
                    //     fontSize: 24,
                    //   ),
                    // ),
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
                                !isDriver ? myTrip.clientId : myTrip.driverId,
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

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
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../profile/provider/profile_provider.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../../request_details/provider/request_details_provider.dart';

class MyPendingTripCard extends StatelessWidget {
  const MyPendingTripCard(
      {required this.myTrip, this.offerPassengers, Key? key})
      : super(key: key);
  final OfferRequestDetailsModel myTrip;
  final int? offerPassengers;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.MY_PENDING_TRIP_DETAILS,
          arguments: myTrip.id!),
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
                            image: myTrip.offer?.clientModel != null
                                ? myTrip.offer?.clientModel?.image ?? ""
                                : myTrip.offer?.driverModel?.image ?? "",
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
                                    myTrip.offer?.clientModel != null
                                        ? "${myTrip.offer?.clientModel?.firstName ?? ""} ${myTrip.offer?.clientModel?.lastName ?? ""} "
                                        : myTrip.offer?.driverModel
                                                ?.firstName ??
                                            "",
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
                                    imageName: myTrip.offer?.clientModel != null
                                        ? myTrip.offer?.clientModel?.gender == 0
                                            ? SvgImages.maleIcon
                                            : SvgImages.femaleIcon
                                        : myTrip.offer?.driverModel?.gender == 0
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
                                myTrip.offer?.clientModel != null
                                    ? myTrip.offer?.clientModel?.national
                                            ?.niceName ??
                                        ""
                                    : myTrip.offer?.driverModel?.national
                                            ?.niceName ??
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
                          flex: 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${getTranslated("start_date", context)} ${myTrip.startAt!.dateFormat(format: "yyyy MMM d")}",
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
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.roadLine),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${myTrip.duration} ${getTranslated("day", context)}",
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
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.wallet),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${myTrip.price} ${getTranslated("sar", context)}",
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
              if (myTrip.approvedAt == null &&
                  !sl.get<ProfileProvider>().isDriver)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                  decoration: BoxDecoration(
                      color: ColorResources.tripStatus("pending"),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    getTranslated("pending", context),
                    style: AppTextStyles.w600.copyWith(
                        fontSize: 12, color: ColorResources.WHITE_COLOR),
                  ),
                ),
              if (sl.get<ProfileProvider>().isDriver)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                  decoration: BoxDecoration(
                      color: ColorResources.tripStatus("pending"),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    getTranslated("pending", context),
                    style: AppTextStyles.w600.copyWith(
                        fontSize: 12, color: ColorResources.WHITE_COLOR),
                  ),
                ),
              if (myTrip.paidAt == null &&
                  myTrip.approvedAt != null &&
                  !sl.get<ProfileProvider>().isDriver)
                InkWell(
                  onTap: () {
                    sl<RequestDetailsProvider>().getRequestDetails(id: myTrip.id!);
                    CustomNavigator.push(Routes.PAYMENT, arguments: true);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                    decoration: BoxDecoration(
                        color: ColorResources.tripStatus("pay"),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      getTranslated("pay", context),
                      style: AppTextStyles.w600.copyWith(
                          fontSize: 12, color: ColorResources.WHITE_COLOR),
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

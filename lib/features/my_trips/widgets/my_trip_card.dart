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

class MyTripCard extends StatelessWidget {
  const MyTripCard(
      {required this.myTrip,
      this.isCurrent = false,
      this.isPending = false,
      this.isPrevious = false,
      this.offerPassengers,
      Key? key})
      : super(key: key);
  final OfferRequestDetailsModel myTrip;
  final int? offerPassengers;
  final bool isCurrent, isPending, isPrevious;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => CustomNavigator.push(Routes.REQUEST_DETAILS, arguments: myTrip.id!),
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
                            image: myTrip.clientModel != null
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
                                    myTrip.clientModel != null
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
                                    imageName: myTrip.clientModel != null
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
                                myTrip.clientModel != null
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
                                      "${myTrip.duration} يوم",
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
                      "${myTrip.price ?? 0}",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w700.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              if (isPrevious)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                  decoration: BoxDecoration(
                      color: ColorResources.tripStatus("replay"),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    getTranslated("replay", context),
                    style: AppTextStyles.w600.copyWith(
                        fontSize: 12, color: ColorResources.WHITE_COLOR),
                  ),
                ),
              if (isPending &&
                  myTrip.approvedAt == null &&
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
              if (isPending && sl.get<ProfileProvider>().isDriver)
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
              if (isPending &&
                  myTrip.approvedAt != null &&
                  !sl.get<ProfileProvider>().isDriver)
                InkWell(
                  onTap: () {
                    sl<RequestDetailsProvider>().getRequestDetails(
                      id: myTrip.id!,
                    );
                    CustomNavigator.push(
                      Routes.PAYMENT,
                    );
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

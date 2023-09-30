import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/marquee_widget.dart';
import '../../../components/show_rate.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../home/widgets/acceptable_analytics_widget.dart';
import '../../profile/provider/profile_provider.dart';
import '../../request_details/model/offer_request_details_model.dart';

class RequestCard extends StatelessWidget {
  final OfferRequestDetailsModel? request;
  final bool isDriver;

  const RequestCard({super.key, this.request, required this.isDriver});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.REQUEST_DETAILS, arguments: request!.id!),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage.circleNewWorkImage(
                                image: sl.get<ProfileProvider>().isDriver
                                    ? request!.clientModel?.image
                                    : request!.driverModel?.image,
                                radius: 16,
                                color: Styles.SECOUND_PRIMARY_COLOR),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          sl.get<ProfileProvider>().isDriver
                                              ? request!
                                                      .clientModel?.firstName ??
                                                  ""
                                              : request!
                                                      .driverModel!.firstName ??
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
                                          imageName: sl
                                                  .get<ProfileProvider>()
                                                  .isDriver
                                              ? request!.clientModel?.gender ==
                                                      0
                                                  ? SvgImages.maleIcon
                                                  : SvgImages.femaleIcon
                                              : request!.driverModel?.gender ==
                                                      0
                                                  ? SvgImages.maleIcon
                                                  : SvgImages.femaleIcon,
                                          color: Styles.BLUE_COLOR,
                                          width: 11,
                                          height: 11)
                                    ],
                                  ),
                                  ShowRate(
                                    rate: sl.get<ProfileProvider>().isDriver
                                        ? request!.clientModel?.rate
                                        : request!.driverModel?.rate,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.h),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.roadLine),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${request?.duration} ${getTranslated("day", context)}",
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles.w400.copyWith(
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.calendar),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${request?.startAt?.defaultFormat()} - ${request?.endAt!.defaultFormat()}",
                                          textAlign: TextAlign.start,
                                          style: AppTextStyles.w400.copyWith(
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.wallet),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${request!.price} ${getTranslated("sar", context)}",
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
                        ),

                        ///car data
                        Visibility(
                          visible: !sl.get<ProfileProvider>().isDriver,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.car,
                                        color: Styles.SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          request!.driverModel?.carInfo?.name ??
                                              "",
                                          style: AppTextStyles.w400.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        height: 10,
                                        width: 1,
                                        color: Styles.HINT_COLOR,
                                        child: const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.carModel,
                                        color: Styles.SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          request!.driverModel?.carInfo
                                                  ?.model ??
                                              "",
                                          style: AppTextStyles.w400.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        height: 10,
                                        width: 1,
                                        color: Styles.HINT_COLOR,
                                        child: const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.seat,
                                        color: Styles.SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${request!.driverModel?.carInfo?.seatsCount} ${getTranslated("persons", context)}",
                                          style: AppTextStyles.w400.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///followers data
                        Visibility(
                          visible: sl.get<ProfileProvider>().isDriver,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated(
                                    "participants_in_this_offer", context),
                                style:
                                    AppTextStyles.w600.copyWith(fontSize: 10),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              request!.followers!.isNotEmpty
                                  ? Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 4.h,
                                      runSpacing: 0,
                                      children: List.generate(
                                        request?.followers?.length ?? 0,
                                        (index) => Row(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              child: Text(
                                                request?.followers?[index]
                                                        .name ??
                                                    "",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: AppTextStyles.w600
                                                    .copyWith(
                                                        fontSize: 14,
                                                        height: 1.25,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            customImageIconSVG(
                                                imageName: request
                                                            ?.followers?[index]
                                                            .gender ==
                                                        0
                                                    ? SvgImages.maleIcon
                                                    : SvgImages.femaleIcon,
                                                color: Styles.BLUE_COLOR,
                                                width: 11,
                                                height: 11),
                                            if (index !=
                                                request!.followers!.length - 1)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Container(
                                                  height: 10,
                                                  width: 1,
                                                  color: Styles.HINT_COLOR,
                                                  child: const SizedBox(),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Text(
                                      getTranslated(
                                          "no_participants_in_this_offer",
                                          context),
                                      style: AppTextStyles.w400
                                          .copyWith(fontSize: 10),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        /// description
                        /* Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated("note", context),
                                    style: AppTextStyles.w600
                                        .copyWith(fontSize: 10),
                                  ),
                                  Text(
                                    "“ يوجد معي راكب بنفس حيك + نفس وجهتك “",
                                    maxLines: 2,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.w,
                            )
                          ],
                        )*/
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Methods.getDayCount(
                          date: request!.createdAt!,
                        ).toString(),
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 10, color: Styles.DISABLED),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AcceptableAnalytics(
                        value: request?.matching ?? 0,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 20.h,
              left: 30.w,
              child: CustomButton(
                text: getTranslated(
                    buttonTitle(
                        isDriver: isDriver,
                        rejected: request?.rejectedAt != null,
                        approved: request?.approvedAt != null,
                        paid: request?.paidAt != null,
                        updateByClient: request?.updatedByClient == true,
                        updateByDriver: request?.updatedByDriver == true),
                    context),
                width: 100,
                height: 30,
                textSize: 12,
                radius: 100,
                backgroundColor: buttonColor(
                    isDriver: isDriver,
                    rejected: request?.rejectedAt != null,
                    approved: request?.approvedAt != null,
                    paid: request?.paidAt != null,
                    updateByClient: request?.updatedByClient == true,
                    updateByDriver: request?.updatedByDriver == true),
                onTap: () => CustomNavigator.push(Routes.REQUEST_DETAILS,
                    arguments: request!.id!),
              ))
        ],
      ),
    );
  }

  buttonTitle(
      {required bool isDriver,
      required bool approved,
      required bool rejected,
      required bool paid,
      required bool updateByDriver,
      required bool updateByClient}) {
    if (rejected) {
      return "rejected";
    } else if (approved && paid) {
      return "paid";
    } else if (approved && !paid) {
      return "pay";
    } else if ((isDriver && updateByDriver) || (!isDriver && updateByClient)) {
      return "pending";
    } else {
      return "preview";
    }
  }

  buttonColor(
      {required bool isDriver,
      required bool approved,
      required bool rejected,
      required bool paid,
      required bool updateByDriver,
      required bool updateByClient}) {
    if (rejected) {
      return Styles.DISABLED;
    } else if (approved && paid) {
      return Styles.DISABLED;
    } else if (approved && !paid) {
      return Styles.PRIMARY_COLOR;
    } else if ((isDriver && updateByDriver) || (!isDriver && updateByClient)) {
      return Styles.DISABLED;
    } else {
      return Styles.PRIMARY_COLOR;
    }
  }
}

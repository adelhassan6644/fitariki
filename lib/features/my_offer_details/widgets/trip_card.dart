import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/marquee_widget.dart';
import '../../../components/rate_stars.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../home/widgets/acceptable_analytics_widget.dart';
import '../../my_offers/model/my_offer.dart';
import '../../profile/provider/profile_provider.dart';

class TripCard extends StatelessWidget {
  final OfferRequest? offerRequest;
  const TripCard({ Key? key, this.offerRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.TRIP_DETAILS,),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
                                image:
                                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                                radius: 16,
                                color: ColorResources.SECOUND_PRIMARY_COLOR),
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
                                          !sl.get<ProfileProvider>().isDriver?offerRequest!.driver!.firstName??"":offerRequest!.client!.firstName??"",

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
                                          imageName: SvgImages.maleIcon,
                                          color: ColorResources.BLUE_COLOR,
                                          width: 11,
                                          height: 11)
                                    ],
                                  ),
                                  const RateStars(
                                    rate: 3,
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
                                          "${offerRequest?.duration} يوم",
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
                                flex: 6,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.calendar),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${offerRequest?.startAt!.defaultFormat()} - ${offerRequest?.endAt!.defaultFormat()}",
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
                                flex: 4,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.wallet),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "${offerRequest!.price} ريال",
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
                        if (! sl.get<ProfileProvider>().isDriver)
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    customImageIconSVG(
                                        imageName: SvgImages.car,
                                        color: ColorResources
                                            .SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "كامري، تايوتا",
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
                                        color: ColorResources.HINT_COLOR,
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
                                        color: ColorResources
                                            .SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "2024",
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
                                        color: ColorResources.HINT_COLOR,
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
                                        imageName: SvgImages.seat,
                                        color: ColorResources
                                            .SECOUND_PRIMARY_COLOR,
                                        height: 14,
                                        width: 14),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: MarqueeWidget(
                                        child: Text(
                                          "5 اشخاص",
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
                        if ( sl.get<ProfileProvider>().isDriver)
                          Column(
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
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "محمد احمد",
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: AppTextStyles.w600.copyWith(
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      customImageIconSVG(
                                          imageName: SvgImages.maleIcon,
                                          color: ColorResources.BLUE_COLOR,
                                          width: 11,
                                          height: 11)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      height: 10,
                                      width: 1,
                                      color: ColorResources.HINT_COLOR,
                                      child: const SizedBox(),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "محمد احمد",
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: AppTextStyles.w600.copyWith(
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      customImageIconSVG(
                                          imageName: SvgImages.maleIcon,
                                          color: ColorResources.BLUE_COLOR,
                                          width: 11,
                                          height: 11)
                                    ],
                                  ),
                                ],
                              ),
                            ],
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
                        "4 ايام",
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 10, color: ColorResources.DISABLED),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const AcceptableAnalytics(
                        value: 0,
                        color: ColorResources.PRIMARY_COLOR,
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
                text: getTranslated("preview", context),
                width: 75.h,
                height: 30.h,
                radius: 100,
                onTap: () =>
                    CustomNavigator.push(Routes.TRIP_DETAILS,),
              ))
        ],
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/rate_stars.dart';
import '../../../navigation/routes.dart';
import '../../profile/provider/profile_provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (BuildContext _, provider, child) {
        return Container(
          color: ColorResources.APP_BAR_BACKGROUND_COLOR,
          child: Column(
            children: [
              SizedBox(height: 15.h + context.toPadding),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 26.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          color: ColorResources.WHITE_COLOR,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 5.0,
                                spreadRadius: -1,
                                offset: const Offset(0, 6))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => CustomNavigator.push(
                                    Routes.EDIT_PROFILE,
                                    arguments: false),
                                child: Text(getTranslated("edit", context),
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        color: ColorResources.SYSTEM_COLOR)),
                              ),
                              const Expanded(child: SizedBox()),
                              Text("4 اسابيع",
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                      color: ColorResources.DISABLED)),
                            ],
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  customImageIconSVG(
                                      imageName: SvgImages.delivered),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                      provider.role == "driver"
                                          ? getTranslated(
                                              "delivery_offers", context)
                                          : getTranslated(
                                              "delivery_requests", context),
                                      style: AppTextStyles.w400.copyWith(
                                        fontSize: 11,
                                      )),
                                  Text("5",
                                      style: AppTextStyles.w700
                                          .copyWith(fontSize: 11, height: 1)),
                                ],
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Container(
                                width: 0.5.w,
                                height: 48.h,
                                color: ColorResources.HINT_COLOR,
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "محمد م..",
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const RateStars(
                                    rate: 3,
                                    size: 6,
                                  ),
                                  Text(
                                    "سعودية",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 11,
                                        height: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Container(
                                width: 0.5.w,
                                height: 48.h,
                                color: ColorResources.HINT_COLOR,
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  customImageIconSVG(
                                      imageName: SvgImages.completed),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                      getTranslated(
                                          "my_completed_travels", context),
                                      style: AppTextStyles.w400.copyWith(
                                        fontSize: 11,
                                      )),
                                  Text("2",
                                      style: AppTextStyles.w700
                                          .copyWith(fontSize: 11, height: 1)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomNetworkImage.circleNewWorkImage(
                        image:
                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                        radius: 36,
                        color: ColorResources.PRIMARY_COLOR),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

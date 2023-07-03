import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../components/show_rate.dart';
import '../../../data/config/di.dart';
import '../../../navigation/routes.dart';
import '../../profile/provider/profile_provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {this.image,
      this.name,

      this.nationality,
      this.distance,
      this.male = true,
      this.isDriver = true,
        this.withPhone = true,
      this.requestsCount,
      this.reservationCount,
      this.rate,
      this.lastUpdate,
      Key? key})
      : super(key: key);

  final String? nationality, name, lastUpdate, distance, image;
  final bool male, withPhone, isDriver;
  final int? requestsCount, reservationCount, rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h + context.toPadding),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 26.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                        distance != null
                            ? RichText(
                                text: TextSpan(
                                  text: "يبعد عنك ",
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                      color:
                                          ColorResources.SECOUND_PRIMARY_COLOR),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: distance,
                                      style: AppTextStyles.w700.copyWith(
                                          fontSize: 10,
                                          color: ColorResources.PRIMARY_COLOR),
                                    ),
                                  ],
                                ),
                              )
                            : InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () {
                                  sl<ProfileProvider>().getProfile();
                                  CustomNavigator.push(Routes.EDIT_PROFILE,
                                      arguments: false);
                                },
                                child: Text(getTranslated("edit", context),
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        color: ColorResources.SYSTEM_COLOR)),
                              ),
                        const Expanded(child: SizedBox()),
                        Text(lastUpdate ?? "ساعة",
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, color: ColorResources.DISABLED)),
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
                            customImageIconSVG(imageName: SvgImages.delivered),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                                isDriver
                                    ? getTranslated("delivery_offers", context)
                                    : getTranslated(
                                        "delivery_requests", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 11,
                                )),
                            Text("$requestsCount",
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
                                    name ?? "",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: AppTextStyles.w600.copyWith(
                                      fontSize: 14,
                                      height: 1.25,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                customImageIconSVG(
                                    imageName: male
                                        ? SvgImages.maleIcon
                                        : SvgImages.femaleIcon,
                                    color: ColorResources.BLUE_COLOR,
                                    width: 11,
                                    height: 11)
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Visibility(
                              visible: withPhone,
                              child: Text(
                                "${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "")}+",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 11,
                                    height: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            ShowRate(
                              rate: rate,
                              size: 6,
                            ),
                            Visibility(
                              visible: !withPhone,
                              child: Text(
                                nationality ?? "سعودي",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 11,
                                    height: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
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
                            customImageIconSVG(imageName: SvgImages.completed),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(getTranslated("my_completed_travels", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 11,
                                )),
                            Text("$reservationCount",
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
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                if(image != null) {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.75),
                    builder: (context) {
                      return ImagePopUpViewer(
                        image: image,
                        isFromInternet: true,
                        title: "",
                      );
                    });
                }
              },
              child: Center(
                child: CustomNetworkImage.circleNewWorkImage(
                    image: image,
                    radius: 36,
                    color: ColorResources.PRIMARY_COLOR),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

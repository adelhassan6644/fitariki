import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/show_rate.dart';
import '../../../data/config/di.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';
import '../../profile/provider/profile_provider.dart';
import '../../profile/widgets/profile_image_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {this.image,
      this.name,
      this.phone,
      this.nationality,
      this.distance,
      this.male = true,
      this.isDriver = true,
      this.withPhone = false,
      this.myProfile = false,
      this.requestsCount,
      this.reservationCount,
      this.rate,
      this.lastUpdate,
      Key? key})
      : super(key: key);

  final LocationModel? distance;
  final String? nationality, name, lastUpdate, image, phone;
  final bool male, withPhone, isDriver;
  final int? requestsCount, reservationCount, rate;
  final bool myProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: !myProfile,
            child: SizedBox(height: 15.h + context.toPadding)),
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
                  color: Styles.WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54.withOpacity(0.1),
                        blurRadius: 7.0,
                        spreadRadius: -1,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        distance != null
                            ? FutureBuilder(
                                future: Methods.calcDistanceFromCurrentLocation(
                                    location: distance),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return RichText(
                                    text: TextSpan(
                                      text: "يبعد عنك ",
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                          color: Styles.SECOUND_PRIMARY_COLOR),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "  ${snapshot.hasData ? snapshot.data ?? "" : "..."} كيلو",
                                          style: AppTextStyles.w700.copyWith(
                                              fontSize: 10,
                                              color: Styles.PRIMARY_COLOR),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
                                        color: Styles.SYSTEM_COLOR)),
                              ),
                        const Expanded(child: SizedBox()),
                        Text(lastUpdate ?? "ساعة",
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, color: Styles.DISABLED)),
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
                          color: Styles.HINT_COLOR,
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      name?.split(" ")[0] ?? "",
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
                                      color: Styles.BLUE_COLOR,
                                      width: 11,
                                      height: 11)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Visibility(
                              visible: withPhone,
                              child: Text(
                                "${phone?.replaceAll("+", "")}+",
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
                              size: 10,
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
                          color: Styles.HINT_COLOR,
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
            ProfileImageWidget(
              fromLogin: false,
              withEdit: false,
              radius: 36,
              image: image,
            ),
          ],
        ),
      ],
    );
  }
}

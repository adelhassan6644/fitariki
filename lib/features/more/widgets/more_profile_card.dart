import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/features/user_profile/page/user_profile.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/show_rate.dart';
import '../../profile/widgets/profile_image_widget.dart';

class MoreProfileCard extends StatelessWidget {
  const MoreProfileCard(
      {required this.id,
      this.image,
      this.name,
      this.nationality,
      this.male = true,
      this.isDriver = true,
      this.reservationCount,
      this.rate,
      this.lastUpdate,
      Key? key})
      : super(key: key);

  final String? nationality, name, lastUpdate, image;
  final bool male, isDriver;
  final int? reservationCount, rate;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          color: Styles.WHITE_COLOR,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 5.0,
                spreadRadius: -1,
                offset: const Offset(3, 6))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  customShowModelBottomSheet(
                      body: Container(
                    height: context.height - (context.toPadding),
                    width: context.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              height: 5.h,
                              width: 36.w,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF3C3C43).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const SizedBox(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            getTranslated(
                                isDriver
                                    ? "preview_clients"
                                    : "preview_drivers",
                                context),
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 1,
                            width: context.width,
                            color: Styles.LIGHT_GREY_BORDER,
                            child: const SizedBox(),
                          ),
                        ),
                        Expanded(
                            child: UserProfile(data: {
                          "id": int.parse(id),
                          "my_profile": true
                        })),
                      ],
                    ),
                  ));
                },
                child: Row(
                  children: [
                    Text("${getTranslated("preview", context)}  ",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 10, color: Styles.DISABLED)),
                    customImageIconSVG(
                        imageName: SvgImages.eyeIcon,
                        color: Styles.SECOUND_PRIMARY_COLOR,
                        width: 14,
                        height: 14)
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(lastUpdate ?? "ساعة",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 10, color: Styles.DISABLED)),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              ProfileImageWidget(
                fromLogin: false,
                withEdit: false,
                radius: 36,
                image: image,
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
                  ShowRate(
                    rate: rate,
                    size: 10,
                  ),
                  Text(
                    nationality ?? "سعودي",
                    textAlign: TextAlign.center,
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
                      style:
                          AppTextStyles.w700.copyWith(fontSize: 11, height: 1)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

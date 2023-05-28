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

class MyTripCard extends StatelessWidget {
  const MyTripCard(
      {this.status,
      this.total,
      this.isCurrent = false,
      this.userNumber,
      Key? key})
      : super(key: key);
  final String? status, total, userNumber;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                            image:
                                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
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
                              width: 50,
                              child: Text(
                                "سعودي",
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
                          flex: isCurrent ? 5 : 3,
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: SvgImages.calendar),
                              const SizedBox(width: 4),
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${getTranslated("start_date", context)}${DateTime.now().dateFormat(format: "yyyy MMM d")}",
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
                                      "20 يوم",
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
                                      "600 ريال",
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
                                      userNumber!,
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
              isCurrent
                  ? Row(
                      children: [
                        customImageIconSVG(
                          imageName: SvgImages.down,
                        ),
                        Text(
                          total!,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w700.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 24),
                      decoration: BoxDecoration(
                          color: ColorResources.tripStatus(status),
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        getTranslated(status!, context),
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 12, color: ColorResources.WHITE_COLOR),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

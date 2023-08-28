import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';

class SubTripCard extends StatelessWidget {
  const SubTripCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8),
      child: Container(
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
          children: [
            Container(
              width: 8,
              height: 115,
              decoration: const BoxDecoration(
                  color: Styles.ACTIVE,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "#_مشوارـ٤",
                      style: AppTextStyles.w600
                          .copyWith(fontSize: 14, color: Styles.ACTIVE),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                          text:
                              getTranslated("vehicle_arrival_approx", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 11,
                              color: Styles.SECOUND_PRIMARY_COLOR),
                          children: [
                            TextSpan(
                              text:
                                  "  ${DateTime.now().dateFormat(format: "hh:mm a")}",
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 14, color: Styles.PRIMARY_COLOR),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            customImageIconSVG(
                                imageName: SvgImages.dotIcon,
                                width: 10,
                                height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Container(
                                height: 12,
                                width: 2,
                                color: Styles.HINT_COLOR,
                              ),
                            ),
                            customImageIconSVG(
                                imageName: SvgImages.dotIcon,
                                width: 10,
                                height: 10)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customImageIconSVG(
                                    imageName: SvgImages.dotIcon,
                                    width: 10,
                                    height: 10),
                                const SizedBox(width: 12,),
                                Text(
                                  "طريق بدون اسم، مطار...٤",
                                  style: AppTextStyles.w400
                                      .copyWith(fontSize: 10,height: 2 , color: Styles.DISABLED),
                                ),
                              ],
                            ),
                           const SizedBox(height: 14,),
                            Text(
                              "طريق بدون اسم، مطار...٤",
                              style: AppTextStyles.w400
                                  .copyWith(fontSize: 10, color: Styles.DISABLED),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

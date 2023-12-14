import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/features/feedback/model/feedback_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/show_rate.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({required this.feedback, Key? key}) : super(key: key);
  final FeedbackItem feedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Styles.CONTAINER_BACKGROUND_COLOR,
                    width: 1)),
            child: Column(
              children: [
                // if(fromProfile)
                Row(
                  children: [
                    CustomNetworkImage.circleNewWorkImage(
                        image: feedback.clientModel?.image,
                        radius: 16,
                        color: Styles.SECOUND_PRIMARY_COLOR),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                feedback.clientModel?.firstName ?? feedback.driverModel?.firstName??"" ,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 14,
                                    height: 1.25,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            customImageIconSVG(
                                imageName: feedback.clientModel?.gender == null? feedback.clientModel?.gender == 0
                                    ? SvgImages.maleIcon
                                    : SvgImages.femaleIcon :  feedback.driverModel?.gender == 0
                                    ? SvgImages.maleIcon
                                    : SvgImages.femaleIcon ,
                                color: Styles.BLUE_COLOR,
                                width: 11,
                                height: 11)
                          ],
                        ),
                        ShowRate(
                          rate: feedback.rate,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),


                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    "“${feedback.feedback ?? ""}”",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: AppTextStyles.w400.copyWith(
                        fontSize: 10, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 4,
              left: 10,
              child: Text(
                Methods.getDayCount(
                      date: feedback.createdAt == null?DateTime.now():feedback.createdAt!,
                    ) ??
                    "",
                style: AppTextStyles.w400
                    .copyWith(color: Styles.HINT_COLOR, fontSize: 10),
              ))
        ],
      ),
    );
  }
}

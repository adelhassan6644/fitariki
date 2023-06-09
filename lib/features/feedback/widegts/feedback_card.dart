import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/feedback/model/feedback_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/show_rate.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({required this.feedback, Key? key}) : super(key: key);
  final FeedbackItem feedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                    width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomNetworkImage.circleNewWorkImage(
                              image: feedback.driverModel != null
                                  ? feedback.driverModel!.image
                                  : feedback.clientModel!.image,
                              radius: 16,
                              color: ColorResources.SECOUND_PRIMARY_COLOR),
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
                                      feedback.driverModel != null
                                          ? feedback.driverModel!.firstName ??
                                              ""
                                          : feedback.clientModel!.firstName ??
                                              "",
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
                                      imageName: feedback.driverModel != null
                                          ? feedback.driverModel!.gender == 0
                                              ? SvgImages.maleIcon
                                              : SvgImages.femaleIcon
                                          : feedback.clientModel!.gender == 0
                                              ? SvgImages.maleIcon
                                              : SvgImages.femaleIcon,
                                      color: ColorResources.BLUE_COLOR,
                                      width: 11,
                                      height: 11)
                                ],
                              ),
                              ShowRate(
                                rate: feedback.driverModel != null
                                    ? feedback.driverModel!.rate
                                    : feedback.clientModel!.rate,
                                size: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ShowRate(
                        rate: feedback.rate,
                        size: 15,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "“${feedback.feedback}”",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // customImageIconSVG(
                //     imageName: isSeen ? SvgImages.seen : SvgImages.notSeen),
                // SizedBox(
                //   width: 8.w,
                // ),
              ],
            ),
          ),
          Positioned(
              top: 4,
              left: 10,
              child: Text(
                Methods.getDayCount(
                      date: feedback.createdAt!,
                    ) ??
                    "",
                style: AppTextStyles.w400
                    .copyWith(color: ColorResources.HINT_COLOR, fontSize: 10),
              ))
        ],
      ),
    );
  }
}

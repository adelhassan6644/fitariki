import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/marquee_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class MyOfferCard extends StatelessWidget {
  const MyOfferCard(
      {this.numberOfDays,
      this.days,
      this.startTime,
      this.endTime,
      this.minPrice,
      this.maxPrice,
      this.createdAt,
      Key? key})
      : super(key: key);
  final int? numberOfDays;
  final String? days;
  final String? startTime, endTime;
  final String? maxPrice, minPrice;
  final String? createdAt;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>CustomNavigator.push(Routes.MY_OFFERS_DETAILS),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 4.h),
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.0,
                  spreadRadius: 1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  customImageIconSVG(imageName: SvgImages.newOffer),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(
                      "عروض جديده",
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 10, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Text(
                    createdAt??"",
                    style: AppTextStyles.w400.copyWith(fontSize: 10, height: 1),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        customImageIconSVG(imageName: SvgImages.roadLine),
                        const SizedBox(height: 4),
                        MarqueeWidget(
                          child: Text(
                            "$numberOfDays يوم ",
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      color: ColorResources.HINT_COLOR,
                      height: 30,
                      width: 1,
                      child: const SizedBox(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        customImageIconSVG(imageName: SvgImages.calendar),
                        const SizedBox(height: 4),
                        MarqueeWidget(
                          child: Text(
                            days ?? "",
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      color: ColorResources.HINT_COLOR,
                      height: 30,
                      width: 1,
                      child: const SizedBox(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        customImageIconSVG(imageName: SvgImages.alarm),
                        const SizedBox(height: 4),
                        MarqueeWidget(
                          child: Text(
                            "${Methods.convertStringToTime(startTime, withFormat: true)}"
                            " - ${Methods.convertStringToTime(endTime, withFormat: true)}ً",
                            maxLines: 1,
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      color: ColorResources.HINT_COLOR,
                      height: 30,
                      width: 1,
                      child: const SizedBox(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        customImageIconSVG(imageName: SvgImages.wallet),
                        const SizedBox(height: 4),
                        MarqueeWidget(
                          child: Text(
                            "$minPrice - $maxPrice",
                            maxLines: 1,
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

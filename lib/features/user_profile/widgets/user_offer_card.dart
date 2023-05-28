import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/methods.dart';
import '../../../components/custom_images.dart';
import '../../../components/marquee_widget.dart';
import '../../../navigation/routes.dart';
import '../../home/widgets/acceptable_analytics_widget.dart';

class UserOfferCard extends StatelessWidget {
  const UserOfferCard({Key? key, required this.offerModel}) : super(key: key);
  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          CustomNavigator.push(Routes.OFFER_DETAILS, arguments: offerModel.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 25.h),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            customImageIconSVG(imageName: SvgImages.roadLine),
                            const SizedBox(width: 4),
                            Expanded(
                              child: MarqueeWidget(
                                child: Text(
                                  "${offerModel.duration} يوم",
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
                      Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            customImageIconSVG(imageName: SvgImages.calendar),
                            const SizedBox(width: 4),
                            Expanded(
                              child: MarqueeWidget(
                                child: Text(
                                  "${offerModel.offerDays!.length} ايام بالإسبوع",
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            customImageIconSVG(imageName: SvgImages.alarm),
                            const SizedBox(width: 4),
                            if (offerModel.offerDays!.isNotEmpty)
                              Expanded(
                                child: MarqueeWidget(
                                  child: Text(
                                    "${Methods.convertStringToTime(offerModel.offerDays?[0].startTime ?? DateTime.now(), withFormat: true)}"
                                    " - ${Methods.convertStringToTime(offerModel.offerDays?[0].endTime ?? DateTime.now(), withFormat: true)}ً",
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
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            customImageIconSVG(imageName: SvgImages.wallet),
                            const SizedBox(width: 4),
                            Expanded(
                              child: MarqueeWidget(
                                child: Text(
                                  "${offerModel.minPrice} - ${offerModel.maxPrice} ريال",
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
                  )
                ],
              ),
            ),
            Positioned(
              left: 10.w,
              child: ClipRect(
                child: SizedBox(
                  height: 85.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Methods.getDayCount(
                          date: offerModel.createdAt!,
                        ).toString(),
                        style: AppTextStyles.w400.copyWith(fontSize: 10),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const AcceptableAnalytics(
                        value: 50,
                        color: ColorResources.PRIMARY_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/my_offers/provider/my_offers_provider.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/marquee_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_models/offer_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class MyOfferCard extends StatefulWidget {
  const MyOfferCard({Key? key, this.offer, this.isFromMyOfferDetails = false})
      : super(key: key);
  final OfferModel? offer;
  final bool isFromMyOfferDetails;

  @override
  State<MyOfferCard> createState() => _MyOfferCardState();
}

class _MyOfferCardState extends State<MyOfferCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.isFromMyOfferDetails
          ? () {
              CustomNavigator.push(Routes.MY_OFFERS_DETAILS, arguments: widget.offer!.id!);
      setState(() {
       widget. offer!.isHaveNewRequests!=false;
      });
      }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 4.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
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
                  if (!widget.isFromMyOfferDetails)
                    Visibility(
                      visible: widget.offer!.isHaveNewRequests!,
                      child: Row(
                        children: [
                          customImageIconSVG(imageName: SvgImages.newOffer),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            sl.get<MyOffersProvider>().isDriver
                                ? getTranslated("new_requests", context)
                                : getTranslated("new_offers", context),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  const Expanded(child: SizedBox()),
                  Text(
                    Methods.getDayCount(
                            date: widget.offer!.createdAt != null
                                ? widget.offer!.createdAt!
                                : DateTime.now())
                        .toString(),
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
                        SizedBox(height: 4.h),
                        MarqueeWidget(
                          child: Text(
                            "${widget.offer!.duration} ${getTranslated("day", context)}",
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
                      color: Styles.HINT_COLOR,
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
                        SizedBox(height: 4.h),
                        MarqueeWidget(
                          child: Text(
                            widget.offer!.offerDays!
                                .map((e) => e.dayName)
                                .toList()
                                .join(", "),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      color: Styles.HINT_COLOR,
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
                        if (widget.offer!.offerDays!.isNotEmpty &&
                            widget.offer!.offerDays?.first.endTime != null)
                          MarqueeWidget(
                            child: Text(
                              "${Methods.convertStringToTime(widget.offer!.offerDays!.first.startTime ?? TimeOfDay.now().toString(), withFormat: true)}"
                              " - ${Methods.convertStringToTime(widget.offer!.offerDays!.first.endTime ?? TimeOfDay.now().toString(), withFormat: true)}ً",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      color: Styles.HINT_COLOR,
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
                            widget.offer!.isSpecial!?"طلب خاص"    :  "${widget.offer!.minPrice} - ${widget.offer!.maxPrice}",
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

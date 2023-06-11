import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/offer_details/provider/offer_details_provider.dart';
import 'package:fitariki/features/offer_details/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/show_rate.dart';
import '../../../main_widgets/shimmer_widgets/reviews_widget_shimmer.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
      return provider.isGetting
          ? const ReviewWidgetShimmer()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getTranslated("display_stats", context),
                                style: AppTextStyles.w600.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Text(
                            //     getTranslated("view_all", context),
                            //     style: AppTextStyles.w400.copyWith(
                            //         fontSize: 11,
                            //         color: ColorResources.DISABLED),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            customImageIconSVG(
                                imageName: SvgImages.profileIcon,
                                color: ColorResources.SECOUND_PRIMARY_COLOR,
                                height: 14,
                                width: 14),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${provider.offerFeedback?.feedbacks?.length ?? ""} ${getTranslated(provider.offerFeedback?.feedbacks?.length == 0 ? "there_is_no_feedbacks_on_this_offer" : "people_benefited_from_this_offer", context)}",
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            ShowRate(
                              rate: provider.offerFeedback?.rate ?? 0,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        ...List.generate(
                            provider.offerFeedback?.feedbacks?.length ?? 0,
                            (index) => ReviewCard(
                                  feedback:
                                      provider.offerFeedback!.feedbacks![index],
                                )),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
    });
  }
}

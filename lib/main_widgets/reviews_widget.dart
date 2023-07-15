import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/feedback/repo/feedback_repo.dart';
import 'package:fitariki/features/offer_details/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_images.dart';
import '../components/show_rate.dart';
import '../data/config/di.dart';
import 'shimmer_widgets/reviews_widget_shimmer.dart';
import '../main_providers/reviews_provider.dart';

class ReviewsWidget extends StatelessWidget {
  final int id;
  final bool isOffer;
  const ReviewsWidget({Key? key, required this.id, required this.isOffer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewsProvider(repo: sl<FeedbackRepo>())..getReviews(id: id, ifOffer: isOffer),
      child: Consumer<ReviewsProvider>(builder: (_, provider, child) {
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
                                  isOffer
                                      ? getTranslated("display_stats", context)
                                      : provider.isDriver
                                          ? getTranslated(
                                                  "clients_evaluation", context)
                                              .replaceAll("لي", "")
                                          : getTranslated(
                                                  "captain_evaluation", context)
                                              .replaceAll("لي", ""),
                                  style: AppTextStyles.w600.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            visible: isOffer,
                            child: Row(
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
                                  "${provider.offerFeedback!.feedbacks!.isEmpty ? "" : provider.offerFeedback?.feedbacks?.length} ${getTranslated(provider.offerFeedback!.feedbacks!.isEmpty ? "there_is_no_feedbacks_on_this_offer" : "people_benefited_from_this_offer", context)}",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                if (provider
                                    .offerFeedback!.feedbacks!.isNotEmpty)
                                  const SizedBox(
                                    width: 4,
                                  ),
                                if (provider
                                    .offerFeedback!.feedbacks!.isNotEmpty)
                                  ShowRate(
                                    rate: provider.offerFeedback?.rate ?? 0,
                                  ),
                                if (provider
                                    .offerFeedback!.feedbacks!.isNotEmpty)
                                  const SizedBox(
                                    height: 8,
                                  ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isOffer &&
                                provider.offerFeedback!.feedbacks!.isEmpty,
                            child: Row(
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
                                  getTranslated(
                                      provider.isDriver
                                          ? "there_is_no_feedbacks_for_this_captain"
                                          : "there_is_no_feedbacks_for_this_client",
                                      context),
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
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
                                    feedback: provider
                                        .offerFeedback!.feedbacks![index],
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
      }),
    );
  }
}

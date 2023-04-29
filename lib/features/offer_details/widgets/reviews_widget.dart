import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/offer_details/widgets/review_card.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/rate_stars.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        getTranslated("view_all", context),
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 11, color: ColorResources.DISABLED),
                      ),
                    ),
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
                      "4 ${getTranslated("people_benefited_from_this_offer", context)}",
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const RateStars(
                      rate: 3,
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
                ...List.generate(5, (index) => const ReviewCard()),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

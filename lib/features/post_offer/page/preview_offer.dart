import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../main_widgets/user_card.dart';
import '../../../main_widgets/map_widget.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/post_offer_provider.dart';

class PreviewOffer extends StatelessWidget {
  const PreviewOffer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height - context.toPadding,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Consumer<PostOfferProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetAppBar(
              title: provider.isDriver
                  ? getTranslated("add_a_delivery_offer", context)
                  : getTranslated("add_a_delivery_request", context),
              textBtn: getTranslated("post", context),
              onTap: () => provider.postOffer(),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  Consumer<ProfileProvider>(
                      builder: (context, profileProvider, child) {
                    return UserCard(
                      image: profileProvider.image,
                      name:
                          "${profileProvider.firstName.text} ${profileProvider.lastName.text}",
                      male: profileProvider.gender == 0,
                      national: profileProvider.nationality?.name,
                      rate: profileProvider.rate,
                      days: provider.scheduleProvider.selectedDays
                          .map((e) => e.dayName)
                          .toList()
                          .join("،"),
                      duration: provider.counts!.count.toString(),
                      priceRange:
                          "${provider.minPrice}- ${provider.maxPrice} SAR",
                      timeRange:
                          "${provider.startTime.dateFormat(format: "mm : hh aa", lang: "ar-SA").replaceAll("AM", "صباحاً").replaceAll("PM", "مساءً")}-  ${provider.endTime.dateFormat(format: "mm : hh aa", lang: "ar-SA").replaceAll("AM", "صباحاً").replaceAll("PM", "مساءً")}",
                      withAnalytics: false,
                    );
                  }),
                  MapWidget(
                    startPoint: provider.startLocation,
                    endPoint: provider.endLocation,
                  ),

                  ///Type of ride
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated("ride_type", context),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          Methods.getOfferType(provider.selectedRideType??1),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../main_widgets/captain_card.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../navigation/routes.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<ProfileProvider>(
            builder: (_, editProfileProvider, child) {
              return BottomSheetAppBar(
                title: editProfileProvider.role == "driver"
                    ? getTranslated("add_a_delivery_offer", context)
                    : getTranslated("add_a_delivery_request", context),
                textBtn: getTranslated("post", context),
                onTap: () {
                  Provider.of<PostOfferProvider>(context,listen: false).postOffer();

                },
              );
            },
          ),
          Consumer<PostOfferProvider>(builder: (_, provider, child) {
            return Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  CaptainCard(
                    days: provider.scheduleProvider.selectedDays
                        .map((e) => e.dayName)
                        .toList()
                        .join("،"),
                    daysNumInWeek: provider.scheduleProvider.selectedDays.length
                        .toString(),
                    daysNum: provider.counts!.count.toString(),
                    priceRange: "${provider.minPrice}- ${provider.maxPrice} SAR",
                    timeRange:
                        "${provider.startTime.dateFormat(format: "hh,mm aa", lang: "ar-SA")}- ${provider.endTime.dateFormat(format: "hh,mm aa", lang: "ar-SA")}",
                    withAnalytics: false,
                  ),
                  MapWidget(
                    startPoint: provider.startLocation,
                    endPoint: provider.endLocation,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

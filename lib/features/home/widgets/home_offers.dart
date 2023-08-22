import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../main_widgets/offer_card.dart';
import '../../../main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import '../provider/home_provider.dart';
import 'home_head_title_widget.dart';

class HomeOffers extends StatelessWidget {
  const HomeOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, homeProvider, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: !homeProvider.isLogin,
            child: HomeHeadTitleWidget(
              title: getTranslated("delivery_offers", context),
              onTap: () => CustomNavigator.push(Routes.ALL_HOME_OFFERS),
            ),
          ),
          Column(
            children: homeProvider.isLoading
                ? List.generate(2, (index) => const ShimmerOfferCard())
                : homeProvider.offer == null || homeProvider.offer!.isEmpty
                    ? [
                        EmptyState(
                          txt: getTranslated(
                              "there_is_no_delivery_requests_or_delivery_offers",
                              context),
                          imgHeight: 80,
                          imgWidth: 80,
                        )
                      ]
                    : List.generate(
                        !homeProvider.isLogin && homeProvider.offer!.length > 2
                            ? 2
                            : homeProvider.offer?.length ?? 0,
                        (index) =>
                            OfferCard(offerModel: homeProvider.offer![index])),
          ),
        ],
      );
    });
  }
}

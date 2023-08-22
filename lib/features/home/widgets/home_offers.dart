import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/offer_card.dart';
import '../../../main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import '../provider/home_provider.dart';
import 'home_head_title_widget.dart';

class HomeOffers extends StatefulWidget {
  const HomeOffers({super.key});

  @override
  State<HomeOffers> createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers>
    with AutomaticKeepAliveClientMixin<HomeOffers> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, sl<HomeProvider>().scroll(controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: Column(
        children: [
          HomeHeadTitleWidget(
            title: getTranslated("delivery_offers", context),
            onTap: () => CustomNavigator.push(Routes.ALL_HOME_OFFERS),
          ),
          Consumer<HomeProvider>(builder: (_, homeProvider, child) {
            return Expanded(
              child: RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  await homeProvider.getOffers();
                },
                child: ListView(
                  controller: controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: homeProvider.isLoading
                      ? List.generate(7, (index) => const ShimmerOfferCard())
                      : homeProvider.offer == null ||
                              homeProvider.offer!.isEmpty
                          ? [
                              EmptyState(
                                  txt: getTranslated(
                                      "there_is_no_delivery_requests_or_delivery_offers",
                                      context))
                            ]
                          : List.generate(
                              homeProvider.offer?.length ?? 0,
                              (index) => OfferCard(
                                  offerModel: homeProvider.offer![index])),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

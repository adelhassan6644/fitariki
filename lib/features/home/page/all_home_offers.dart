import 'package:fitariki/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../../main_widgets/offer_card.dart';
import '../../../main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import '../provider/home_provider.dart';

class AllHomeOffers extends StatefulWidget {
  const AllHomeOffers({super.key});

  @override
  State<AllHomeOffers> createState() => _AllHomeOffersState();
}

class _AllHomeOffersState extends State<AllHomeOffers> {
  // ScrollController controller = ScrollController();

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, sl<HomeProvider>().scroll(controller));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("delivery_offers", context)),
      body: SafeArea(
        top: false,
        child: Column(children: [
          const SizedBox(
            height: 12,
          ),
          Consumer<HomeProvider>(builder: (_, homeProvider, child) {
            return Expanded(
              child: RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  await homeProvider.getOffers();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 12),
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
          })
        ]),
      ),
    );
  }
}

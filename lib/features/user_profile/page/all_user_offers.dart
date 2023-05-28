import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../home/provider/home_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/user_offer_card.dart';

class AllUserOffers extends StatelessWidget {
  const AllUserOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: sl.get<ProfileProvider>().isDriver
                  ? getTranslated("current_requests", context)
                  : getTranslated("current_offers", context),
              withBorder: true,
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: ListAnimator(
                data: [
                  ...List.generate(
                      sl<HomeProvider>().offer!.length > 3
                          ? 3
                          : sl<HomeProvider>().offer!.length,
                      (index) => UserOfferCard(
                          offerModel: sl<HomeProvider>().offer![index])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

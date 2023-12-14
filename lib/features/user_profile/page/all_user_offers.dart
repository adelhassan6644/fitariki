import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/user_profile/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
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
              title: sl.get<UserProfileProvider>().isDriver
                  ? getTranslated("current_requests", context)
                  : getTranslated("current_offers", context),
              withBorder: true,
            ),
            SizedBox(
              height: 8.h,
            ),
            Consumer<UserProfileProvider>(builder: (_, provider, child) {
              return Expanded(
                child: ListAnimator(
                  data: [
                    ...List.generate(
                        provider.userOffers?.offers?.length ?? 0,
                        (index) => UserOfferCard(
                            offerModel: provider.userOffers!.offers![index])),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

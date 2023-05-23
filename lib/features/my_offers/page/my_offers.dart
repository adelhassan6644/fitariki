import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/methods.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../guest/guest_mode.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/my_offers_provider.dart';
import '../widgets/my_offer_card.dart';

class MyOffers extends StatelessWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, profileProvider, child) {
      return Column(
        children: [
          CustomAppBar(
            title: profileProvider.roleType != null
                ? profileProvider.isDriver
                    ? getTranslated("delivery_requests", context)
                    : getTranslated("delivery_offers", context)
                : getTranslated("offers_or_requests", context),
            withBorder: true,
            withBack: false,
          ),
          profileProvider.isLogin
              ? Expanded(
                  child:
                      Consumer<MyOffersProvider>(builder: (_, provider, child) {
                    return ListAnimator(
                      data: [
                        SizedBox(
                          height: 8.h,
                        ),
                        ...List.generate(
                            5,
                            (index) => MyOfferCard(
                                  startTime: "6:30:00",
                                  endTime: "18:30:00",
                                  minPrice: "200",
                                  maxPrice: "200",
                                  numberOfDays: 20,
                                  days: "الأحد، الإثنين، الثلاثاء،الإربعاء",
                                  createdAt: Methods.getDayCount(
                                    date: DateTime(2023, 5, 11, 12, 30, 30),
                                  ).toString(),
                                ))
                      ],
                    );
                  }),
                )
              : const Expanded(child: GuestMode()),
        ],
      );
    });
  }
}

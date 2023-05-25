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

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  State<MyOffers> createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<MyOffersProvider>(context, listen: false).getMyOffer();
    });
    super.initState();
  }

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
                    if (provider.isLoading) {
                      return const CupertinoActivityIndicator();
                    }

                    return ListAnimator(
                      data: [
                        SizedBox(
                          height: 8.h,
                        ),
                        ...List.generate(
                            provider.offer?.length ?? 0,
                            (index) => MyOfferCard(
                                  offer: provider.offer![index],
                                  startTime:provider
                                      .offer![index].offerDays!.isNotEmpty? provider
                                      .offer![index].offerDays?.first.startTime:null,
                                  endTime: provider
                                      .offer![index].offerDays!.isNotEmpty?provider
                                      .offer![index].offerDays?.first.endTime:null,
                                  minPrice: provider.offer![index].minPrice
                                      .toString(),
                                  maxPrice: provider.offer![index].maxPrice
                                      .toString(),
                                  numberOfDays: provider.offer![index].duration,
                                  days: provider.offer![index].offerDays,
                                  createdAt: Methods.getDayCount(
                                    date: provider.offer![index].createdAt!,
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

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/empty_widget.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
      if (Provider.of<ProfileProvider>(context, listen: false).isLogin) {
        Provider.of<MyOffersProvider>(context, listen: false).getMyOffer();
      }
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
                    ? getTranslated("delivery_offers", context)
                    : getTranslated("delivery_requests", context)
                : getTranslated("offers_or_requests", context),
            withBorder: true,
            withBack: false,
          ),
          profileProvider.isLogin
              ? Expanded(
                  child:
                      Consumer<MyOffersProvider>(builder: (_, provider, child) {
                    if (!provider.isLoading) {
                      return ListAnimator(
                        data: [
                          SizedBox(
                            height: 8.h,
                          ),
                          if (provider.myOffers!.offers != null ||
                              provider.myOffers!.offers!.isNotEmpty)
                            ...List.generate(
                                provider.myOffers!.offers!.length,
                                (index) => MyOfferCard(
                                      offer: provider.myOffers!.offers![index],
                                    )),
                          if (provider.myOffers!.offers == null ||
                              provider.myOffers!.offers!.isEmpty)
                            EmptyState(
                                txt: profileProvider.isDriver
                                    ? "لا يوجد عروض توصيل حاليا \n أضف عرض جديد"
                                    : "لا يوجد طلبات توصيل حاليا \n أضف طلب جديد")
                        ],
                      );
                    }

                    return ListAnimator(
                      data: [
                        SizedBox(
                          height: 8.h,
                        ),
                        ...List.generate(
                            5,
                            (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT.w,
                                      vertical: 8.h),
                                  child: CustomShimmerContainer(
                                    width: context.width,
                                    height: 80.h,
                                    radius: 8,
                                  ),
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

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/empty_widget.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../guest/guest_mode.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/my_offers_provider.dart';
import '../widgets/my_offer_card.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  State<MyOffers> createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers>
    with AutomaticKeepAliveClientMixin<MyOffers> {
  @override
  void initState() {
    if (sl<MyOffersProvider>().isLogin) {
      Future.delayed(Duration.zero,(){sl<MyOffersProvider>().getMyOffers();});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProfileProvider>(builder: (_, profileProvider, child) {
      return Column(
        children: [
          CustomAppBar(
            title: profileProvider.isLogin
                ? profileProvider.isDriver
                    ? getTranslated("delivery_offers", context)
                    : getTranslated("delivery_requests", context)
                : getTranslated("offers_or_requests", context),
            withBorder: true,
            withBack: false,
          ),
          profileProvider.isLogin
              ? Consumer<MyOffersProvider>(builder: (_, provider, child) {
                  return !provider.isLoading
                      ? Expanded(
                          child: RefreshIndicator(
                            color: Styles.PRIMARY_COLOR,
                            onRefresh: () async {
                              sl<MyOffersProvider>().getMyOffers();
                            },
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              children: [
                                SizedBox(
                                  height: 8.h,
                                ),
                                if (provider.myOffers?.offers != null &&
                                    provider.myOffers!.offers!.isNotEmpty)
                                  ...List.generate(
                                      provider.myOffers!.offers!.length,
                                      (index) => MyOfferCard(
                                            offer: provider
                                                .myOffers!.offers![index],
                                          )),
                                if (provider.myOffers?.offers == null ||
                                    provider.myOffers!.offers!.isEmpty)
                                  EmptyState(
                                      txt: profileProvider.isDriver
                                          ? getTranslated(
                                              "there_is_no_offers_add_new_offer",
                                              context)
                                          : getTranslated(
                                              "there_is_no_requests_add_new_request",
                                              context)),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListAnimator(
                            data: [
                              SizedBox(
                                height: 8.h,
                              ),
                              ...List.generate(
                                  5,
                                  (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_DEFAULT.w,
                                            vertical: 8.h),
                                        child: CustomShimmerContainer(
                                          width: context.width,
                                          height: 80.h,
                                          radius: 8,
                                        ),
                                      ))
                            ],
                          ),
                        );
                })
              : const Expanded(child: GuestMode()),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/methods.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/shimmer_widgets/offer_details_shimmer.dart';
import '../../../main_widgets/user_card.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../auth/pages/login.dart';
import '../../profile/provider/profile_provider.dart';
import '../../add_offer/page/add_offer.dart';
import '../../wishlist/provider/wishlist_provider.dart';
import '../provider/offer_details_provider.dart';
import '../widgets/car_details.dart';
import '../widgets/reviews_widget.dart';

class OfferDetails extends StatefulWidget {
  final int offerId;
  const OfferDetails({Key? key, required this.offerId}) : super(key: key);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<OfferDetailsProvider>(context, listen: false)
          .getOfferDetails(offerId: widget.offerId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              Consumer<ProfileProvider>(builder: (_, provider, child) {
                return CustomAppBar(
                  title: provider.isDriver
                      ? getTranslated("delivery_request", context)
                      : getTranslated("delivery_offer", context),
                  withSave: true,
                  onSave: () {
                    if (provider.isLogin) {
                      sl<WishlistProvider>()
                          .postWishList(offerId: widget.offerId);
                    }
                  },
                );
              }),
              !provider.isLoading
                  ? Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        children: [
                          Container(
                              color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                              child: UserCard(
                                isDriver: sl.get<ProfileProvider>().isDriver,
                                withAnalytics: true,
                                createdAt: provider.offerDetails!.createdAt!,
                                days: provider.day,
                                daysNum:
                                    provider.offerDetails!.duration.toString(),
                                name: provider.offerDetails?.name,
                                priceRange:
                                    "${provider.offerDetails!.minPrice.toString()} : ${provider.offerDetails!.maxPrice.toString()} ريال",
                                followers: provider
                                    .offerDetails!.followers?.length
                                    .toString(),
                                timeRange: provider
                                        .offerDetails!.offerDays!.isEmpty
                                    ? ""
                                    : "${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].endTime, withFormat: true)}",
                              )),
                          MapWidget(
                            startPoint: provider.offerDetails!.pickLocation,
                            endPoint: provider.offerDetails!.endLocation,
                          ),
                          DistanceWidget(
                            isCaptain: sl.get<ProfileProvider>().isDriver,
                          ),
                          if (!sl.get<ProfileProvider>().isDriver)
                            const CarDetails(),
                          if (!sl.get<ProfileProvider>().isDriver)
                            const ReviewsWidget()
                        ],
                      ),
                    )
                  : const OfferDetailsShimmer(),
              if (!provider.isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: 24),
                  child: CustomButton(
                    text: sl.get<ProfileProvider>().isDriver
                        ? getTranslated("add_request", context)
                        : getTranslated("add_offer", context),
                    onTap: () => customShowModelBottomSheet(
                      body: sl.get<ProfileProvider>().isLogin
                          ? AddOffer(
                              name: provider.offerDetails?.name ?? "",
                              tripID: widget.offerId,
                              isCaptain: sl.get<ProfileProvider>().isDriver,
                            )
                          : const Login(),
                    ),
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}

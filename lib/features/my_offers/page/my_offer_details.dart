import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/methods.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/empty_widget.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/shimmer_widgets/my_offer_details_shimmer.dart';
import '../provider/my_offers_provider.dart';
import '../widgets/delete_offer_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../navigation/routes.dart';
import '../widgets/my_offer_card.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/request_card.dart';

class MyOfferDetails extends StatefulWidget {
  final int offerId;
  const MyOfferDetails({Key? key, required this.offerId}) : super(key: key);

  @override
  State<MyOfferDetails> createState() => _MyOfferDetailsState();
}

class _MyOfferDetailsState extends State<MyOfferDetails>
    with AutomaticKeepAliveClientMixin<MyOfferDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<MyOffersProvider>().getMyOfferDetails(id: widget.offerId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(
          title: sl.get<ProfileProvider>().isDriver
              ? getTranslated("delivery_offer_details", context)
              : getTranslated("delivery_request_details", context),
          actionChild: DeleteOfferWidget(
            id: widget.offerId,
          )),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Consumer<MyOffersProvider>(builder: (context, provider, _) {
              return !provider.isOfferDetailsLoading &&
                      provider.myOfferDetails != null
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ListAnimator(
                          data: [
                            MyOfferCard(
                              offer: provider.myOfferDetails,
                              isFromMyOfferDetails: true,
                            ),

                            ///My Offer Details
                            ExpansionTileWidget(
                              iconColor: Styles.SECOUND_PRIMARY_COLOR,
                              withTitlePadding: true,
                              title: getTranslated(
                                  provider.isDriver
                                      ? "delivery_offer_details"
                                      : "delivery_request_details",
                                  context),
                              children: [
                                ///Offer Map
                                MapWidget(
                                  startPoint:
                                      provider.myOfferDetails?.pickupLocation,
                                  endPoint:
                                      provider.myOfferDetails?.dropOffLocation,
                                ),

                                ///Followers Map
                                if (provider
                                    .myOfferDetails!.offerFollowers!.isNotEmpty)
                                  ...List.generate(
                                    provider.myOfferDetails?.offerFollowers
                                            ?.length ??
                                        0,
                                    (index) => MapWidget(
                                      clientName: provider.myOfferDetails
                                              ?.offerFollowers?[index].name ??
                                          "",
                                      gender: provider.myOfferDetails
                                          ?.offerFollowers?[index].gender,
                                      startPoint: provider
                                          .myOfferDetails
                                          ?.offerFollowers?[index]
                                          .pickupLocation,
                                      endPoint: provider
                                          .myOfferDetails
                                          ?.offerFollowers?[index]
                                          .dropOffLocation,
                                    ),
                                  ),

                                ///Type of ride
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT.w,
                                      vertical:
                                          Dimensions.PADDING_SIZE_DEFAULT.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getTranslated("ride_type", context),
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.w600.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        Methods.getOfferType(provider
                                                .myOfferDetails?.offerType ??
                                            1),
                                        textAlign: TextAlign.end,
                                        style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            ///Offers on request
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                  vertical: 16.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      sl.get<ProfileProvider>().isDriver
                                          ? getTranslated("requests", context)
                                          : getTranslated("offers", context),
                                      style: AppTextStyles.w600
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  if (provider.myOfferDetails != null &&
                                      provider.myOfferDetails!.offerRequests!
                                          .isNotEmpty &&
                                      provider.myOfferDetails!.offerRequests!
                                              .length >
                                          3)
                                    InkWell(
                                      onTap: () => CustomNavigator.push(
                                        Routes.ALL_REQUESTS,
                                      ),
                                      child: Text(
                                        getTranslated("view_all", context),
                                        style: AppTextStyles.w400.copyWith(
                                            fontSize: 11,
                                            color: Styles.DISABLED),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: provider.myOfferDetails?.offerRequests !=
                                      null &&
                                  provider.myOfferDetails!.offerRequests!
                                      .isNotEmpty,
                              child: Column(
                                children: List.generate(
                                    provider.myOfferDetails!.offerRequests!
                                                .length >
                                            3
                                        ? 3
                                        : provider.myOfferDetails!
                                            .offerRequests!.length,
                                    (index) => RequestCard(
                                          request: provider.myOfferDetails!
                                              .offerRequests![index],
                                        )),
                              ),
                            ),
                            Visibility(
                              visible: provider.myOfferDetails?.offerRequests ==
                                      null ||
                                  provider
                                      .myOfferDetails!.offerRequests!.isEmpty,
                              child: EmptyState(
                                  txt: sl.get<ProfileProvider>().isDriver
                                      ? getTranslated(
                                          "there_is_no_offers_now", context)
                                      : getTranslated(
                                          "there_is_no_requests_now", context)),
                            )
                          ],
                        ),
                      ),
                    )
                  : const MyOfferDetailsShimmer();
            }),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

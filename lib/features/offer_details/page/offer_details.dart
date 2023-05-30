import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/maps/provider/location_provider.dart';
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
              CustomAppBar(
                title: provider.isLoading? "" : provider.offerDetails?.clientId != null
                    ? getTranslated("delivery_request", context)
                    : getTranslated("delivery_offer", context),
                savedItemId:  widget.offerId,
              ),
              !provider.isLoading
                  ? Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        children: [
                          Container(
                              color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                              child: UserCard(
                                userId: provider.offerDetails!.clientId != null
                                    ? provider.offerDetails!.clientId!
                                    : provider.offerDetails!.driverId!,
                                isDriver:
                                provider.offerDetails?.driverId != null
                                        ? true
                                        : false,
                                createdAt: provider.offerDetails!.createdAt!,
                                days: provider.offerDetails!.offerDays!
                                    .map((e) => e.dayName)
                                    .toList()
                                    .join(", "),
                                duration:
                                provider.offerDetails!.duration.toString(),
                                name: provider.offerDetails?.name,
                                priceRange:
                                    "${provider.offerDetails!.minPrice.toString()} : ${provider.offerDetails!.maxPrice.toString()} ريال",
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
                            isCaptain: provider.offerDetails?.driverId == null
                                ? true
                                : false,
                            lat1: sl<LocationProvider>().currentLocation!.latitude!,
                            long1:
                            sl<LocationProvider>().currentLocation!.longitude!,
                            lat2: sl<LocationProvider>().currentLocation!.latitude!,
                            long2:  sl<LocationProvider>().currentLocation!.longitude!,
                          ),

                          if (provider.offerDetails?.clientId == null)
                            const CarDetails(),
                          if (provider.offerDetails?.clientId == null)
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
                        ? getTranslated("add_offer", context)
                        : getTranslated("add_request", context),
                    onTap: () => customShowModelBottomSheet(
                      body: sl.get<ProfileProvider>().isLogin
                          ? AddOffer(
                              name: provider.offerDetails?.name ?? "",
                              offer: provider.offerDetails!,
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

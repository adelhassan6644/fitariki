import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/maps/provider/location_provider.dart';
import 'package:fitariki/features/offer_details/repo/offer_details_repo.dart';
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
import '../../add_request/page/add_request.dart';
import '../../add_request/provider/add_request_provider.dart';
import '../../auth/pages/login.dart';
import '../provider/offer_details_provider.dart';
import '../widgets/car_details.dart';
import '../widgets/reviews_widget.dart';

class OfferDetails extends StatelessWidget {
  final int offerId;
  const OfferDetails({Key? key, required this.offerId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: ChangeNotifierProvider(
          create: (_) => OfferDetailsProvider(repo: sl<OfferDetailsRepo>())
            ..getOfferDetails(offerId: offerId),
          child: Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                CustomAppBar(
                  title: provider.isDriver
                      ? getTranslated("delivery_request", context)
                      : getTranslated("delivery_offer", context),
                  savedItemId: offerId,
                ),
                !provider.isLoading && provider.offerDetails != null
                    ? Expanded(
                        child: ListAnimator(
                          data: [
                            Container(
                                color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                                child: UserCard(
                                  userId: provider.isDriver
                                      ? provider.offerDetails?.clientId
                                      : provider.offerDetails?.driverId,
                                  name: provider.isDriver
                                      ? "${provider.offerDetails!.clientModel?.firstName} ${provider.offerDetails!.clientModel?.lastName}"
                                      : provider
                                          .offerDetails!.driverModel?.firstName,
                                  male: provider.isDriver
                                      ? provider.offerDetails!.clientModel
                                              ?.gender ==
                                          0
                                      : provider.offerDetails!.driverModel
                                              ?.gender ==
                                          0,
                                  national: provider.isDriver
                                      ? provider.offerDetails!.clientModel
                                          ?.national?.niceName
                                      : provider.offerDetails!.driverModel
                                          ?.national?.niceName,
                                  createdAt: provider.offerDetails!.createdAt!,
                                  days: provider.offerDetails!.offerDays!
                                      .map((e) => e.dayName)
                                      .toList()
                                      .join(", "),
                                  duration: provider.offerDetails!.duration
                                      .toString(),
                                  priceRange:
                                      "${provider.offerDetails!.minPrice.toString()} : ${provider.offerDetails!.maxPrice.toString()} ريال",
                                  timeRange: provider
                                          .offerDetails!.offerDays!.isEmpty
                                      ? ""
                                      : "${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.offerDetails!.offerDays![0].endTime, withFormat: true)}",
                                )),
                            MapWidget(
                              startPoint: provider.offerDetails!.pickupLocation,
                              endPoint: provider.offerDetails!.dropOffLocation,
                            ),
                            DistanceWidget(
                              isCaptain: provider.isDriver,
                              lat1: sl<LocationProvider>()
                                  .currentLocation!
                                  .latitude!,
                              long1: sl<LocationProvider>()
                                  .currentLocation!
                                  .longitude!,
                              lat2: provider
                                  .offerDetails!.pickupLocation!.latitude!,
                              long2: provider
                                  .offerDetails!.pickupLocation!.longitude!,
                            ),
                            if (!provider.isDriver)
                              CarDetails(
                                carInfo:
                                    provider.offerDetails?.driverModel?.carInfo,
                              ),
                            if (!provider.isDriver) const ReviewsWidget()
                          ],
                        ),
                      )
                    : OfferDetailsShimmer(
                        isDriver: provider.isDriver,
                      ),
                if (!provider.isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: 24),
                    child: CustomButton(
                        textColor: provider.offerDetails?.isSentOffer == true
                            ? ColorResources.PRIMARY_COLOR
                            : ColorResources.WHITE_COLOR,
                        backgroundColor:
                            provider.offerDetails?.isSentOffer == true
                                ? ColorResources.PRIMARY_COLOR.withOpacity(0.1)
                                : ColorResources.PRIMARY_COLOR,
                        text: provider.offerDetails?.isSentOffer == true
                            ? getTranslated(
                                provider.isDriver
                                    ? "offer_sent"
                                    : "request_sent",
                                context)
                            : getTranslated(
                                provider.isDriver ? "add_offer" : "add_request",
                                context),
                        onTap: () {
                          if (provider.offerDetails?.isSentOffer != true) {
                            customShowModelBottomSheet(
                                onClose: () => sl<AddRequestProvider>().reset(),
                                body: provider.isLogin
                                    ? AddRequest(
                                        name: provider.offerDetails?.name ?? "",
                                        offer: provider.offerDetails!,
                                        isCaptain: provider.isDriver,
                                      )
                                    : const Login());
                          }
                        }),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}

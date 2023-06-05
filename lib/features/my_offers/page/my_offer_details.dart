import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/empty_widget.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_models/offer_model.dart';
import '../widgets/delete_offer_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../navigation/routes.dart';
import '../widgets/my_offer_card.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/request_card.dart';

class MyOfferDetails extends StatefulWidget {
  final OfferModel offer;
  const MyOfferDetails({Key? key, required this.offer}) : super(key: key);

  @override
  State<MyOfferDetails> createState() => _MyOfferDetailsState();
}

class _MyOfferDetailsState extends State<MyOfferDetails>with AutomaticKeepAliveClientMixin<MyOfferDetails>  {
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
                  ? getTranslated("delivery_offer_details", context)
                  : getTranslated("delivery_request_details", context),
              actionChild: DeleteOfferWidget(id: widget.offer.id!,)
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                    height: 50.h,
                    width: context.width,
                  ),
                  ListAnimator(
                    data: [
                      MyOfferCard(
                        offer: widget.offer,
                      ),
                      MapWidget(
                        startPoint: widget.offer.pickupLocation,
                        endPoint: widget.offer.dropOffLocation,
                      ),
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
                                style:
                                    AppTextStyles.w600.copyWith(fontSize: 16),
                              ),
                            ),
                            if (widget.offer.offerRequests != null &&
                                widget.offer.offerRequests!.isNotEmpty &&
                                widget.offer.offerRequests!.length > 3)
                              InkWell(
                                onTap: () => CustomNavigator.push(
                                  Routes.ALL_REQUESTS,
                                ),
                                child: Text(
                                  getTranslated("view_all", context),
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 11,
                                      color: ColorResources.DISABLED),
                                ),
                              )
                          ],
                        ),
                      ),
                      if (widget.offer.offerRequests != null &&
                          widget.offer.offerRequests!.isNotEmpty)
                        ...List.generate(
                            widget.offer.offerRequests!.length > 3
                                ? 3
                                : widget.offer.offerRequests!.length,
                            (index) => RequestCard(
                                  request: widget.offer.offerRequests![index],
                                )),
                      if (widget.offer.offerRequests == null ||
                          widget.offer.offerRequests!.isEmpty)
                        EmptyState(
                            txt: sl.get<ProfileProvider>().isDriver
                                ? "لا يوجود عروض الان"
                                : "لا يوجود طلبات الان")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

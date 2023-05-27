import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/maps/models/location_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/map_widget.dart';
import '../../../navigation/routes.dart';
import '../../my_offers/model/my_offer.dart';
import '../../my_offers/widgets/my_offer_card.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/trip_card.dart';

class MyOfferDetails extends StatelessWidget {
  final MyOfferModel myOfferDetails;
  const MyOfferDetails({Key? key,required this.myOfferDetails}) : super(key: key);

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
                  ? getTranslated("delivery_request_details", context)
                  : getTranslated("delivery_offer_details", context),
              actionChild: InkWell(
                onTap: () {},
                child: Text(
                  getTranslated("delete", context),
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: ColorResources.RED_COLOR),
                ),
              ),
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

                        startTime: myOfferDetails.offerDays?.first.startTime,
                        endTime: myOfferDetails.offerDays?.first.endTime,
                        minPrice: myOfferDetails.minPrice.toString(),
                        maxPrice:  myOfferDetails.maxPrice.toString(),
                        numberOfDays: myOfferDetails.duration,
                        days: myOfferDetails.offerDays,
                        createdAt: Methods.getDayCount(
                          date: myOfferDetails.createdAt!,
                        ).toString(),
                      ),

                      MapWidget(
                        startPoint: myOfferDetails.pickupLocation,
                        endPoint:myOfferDetails.dropOffLocation ,
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
                                    ? getTranslated("offers", context)
                                    : getTranslated("requests", context),
                                style:
                                    AppTextStyles.w600.copyWith(fontSize: 16),
                              ),
                            ),
                            InkWell(
                              onTap: () => CustomNavigator.push(
                                Routes.ALL_TRIPS,
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
                      ...List.generate(
                          2,
                          (index) =>  const TripCard()),

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
}

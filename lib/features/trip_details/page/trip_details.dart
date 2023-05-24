import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/custom_button.dart';
import 'package:fitariki/features/trip_details/provider/trip_details_provider.dart';
import 'package:fitariki/main_widgets/user_card.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../maps/models/location_model.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/car_trip_details_widget.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: getTranslated("trip", context),
            ),
            Expanded(
              child:  ListAnimator(
                data: [
                  UserCard(
                    withAnalytics: false,
                    days: "الأحد، الإثنين، الثلاثاء",
                    daysNum: "10",
                    priceRange: "200",
                    createdAt: "4",
                    isDriver: sl.get<ProfileProvider>().isDriver,
                    followers: "2",
                  ),
                  MapWidget(
                    stopPoints:
                    sl.get<ProfileProvider>().isDriver ? 2 : null,
                    startPoint: LocationModel(
                        longitude: "20",
                        latitude: "20.2",
                        address:
                        "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                    endPoint: LocationModel(
                        longitude: "20.13",
                        latitude: "20.25",
                        address:
                        "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                  ),
                  DistanceWidget(
                    isCaptain: sl.get<ProfileProvider>().isDriver,
                  ),
                  if (sl.get<ProfileProvider>().isDriver)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: Text(
                        getTranslated("stop_points", context),
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (sl.get<ProfileProvider>().isDriver)
                    ...List.generate(
                      2,
                          (index) => MapWidget(
                        clientName: "يارا محمد",
                        gender: 1,
                        startPoint: LocationModel(
                            longitude: "20",
                            latitude: "20.2",
                            address:
                            "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                        endPoint: LocationModel(
                            longitude: "20.13",
                            latitude: "20.25",
                            address:
                            "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                      ),
                    ),
                  if (!sl.get<ProfileProvider>().isDriver)
                    const CarTripDetailsWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("note", context),
                                style: AppTextStyles.w600
                                    .copyWith(fontSize: 10),
                              ),
                              Text(
                                "“ يوجد معي راكب بنفس حيك + نفس وجهتك “",
                                maxLines: 2,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: CustomButton(
                  text: sl.get<ProfileProvider>().isDriver
                      ? getTranslated("accept_offer", context)
                      : getTranslated("accept_request", context),
              onTap: (){
                    if(!sl.get<ProfileProvider>().isDriver){
                      CustomNavigator.push(Routes.PAYMENT);
                    }
              },),
            ),
            Consumer<TripDetailsProvider>(
              builder: (_,provider,child) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: CustomButton(
                    text: getTranslated("negotiation", context),
                    backgroundColor: ColorResources.WHITE_COLOR,
                    withBorderColor: true,
                    textColor: ColorResources.PRIMARY_COLOR,
                    onTap: ()=>CupertinoPopUpHelper.showCupertinoTextController(controller: provider.negotiationPrice),
                  ),
                );
              }
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: CustomButton(
                text: sl.get<ProfileProvider>().isDriver
                    ? getTranslated("reject_offer", context)
                    : getTranslated("reject_request", context),
                backgroundColor: ColorResources.WHITE_COLOR,
                withBorderColor: true,
                textColor: ColorResources.PRIMARY_COLOR,
              ),
            ),
            SizedBox(
              height: 24.h,
            )
          ],
        ),
      ),
    );
  }
}

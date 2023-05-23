import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/main_widgets/captain_card.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
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
              child: Stack(
                children: [
                  Container(
                    color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                    height: 50.h,
                    width: context.width,
                  ),
                  ListAnimator(
                    data: [
                      UserCard(
                        days: "الأحد، الإثنين، الثلاثاء",
                        daysNum: "10",
                        priceRange: "200",
                        createdAt: "4",
                        isDriver: sl.get<ProfileProvider>().isDriver,
                      ),
                      MapWidget(
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
                      if (!sl.get<ProfileProvider>().isDriver)
                        const CarTripDetailsWidget()
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

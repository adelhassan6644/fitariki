import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/trip_card.dart';

class AllTrips extends StatelessWidget {
  const AllTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: !sl.get<ProfileProvider>().isDriver
                  ? getTranslated("offers", context)
                  : getTranslated("requests", context),
              withBorder: true,
            ),
            SizedBox(height: 8.h,),
            Expanded(
              child: ListAnimator(
                data: [
                  ...List.generate(
                      3,
                      (index) => const TripCard()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

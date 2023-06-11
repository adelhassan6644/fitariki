import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_app_bar.dart';
import '../../guest/guest_mode.dart';
import '../provider/my_trips_provider.dart';
import '../widgets/current_trips_widget.dart';
import '../widgets/pending_trips_widget.dart';
import '../widgets/previous_trips_widget.dart';
import '../widgets/tab_bar_widget.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWidget = [
      const PreviousTripsWidget(),
      const CurrentTripsWidget(),
      const PendingTripsWidget()
    ];
    return Consumer<MyTripsProvider>(
      builder: (_, myTripProvider, child) {
        return Column(
          children: [
            CustomAppBar(
              title: getTranslated("my_trips", context),
              withBorder: true,
              withBack: false,
            ),
            SizedBox(
              height: 8.h,
            ),
            TabBerWidget(
              provider: myTripProvider,
            ),
            myTripProvider.isLogin
                ? Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          if (myTripProvider.currentTap == 0) {
                            await myTripProvider.getPreviousTrips();
                          } else if (myTripProvider.currentTap == 1) {
                            await myTripProvider.getCurrentTrips();
                          } else {
                            await myTripProvider.getPendingTrips();
                          }
                        },
                        child: Column(
                          children: [
                            currentWidget[myTripProvider.currentTap],
                          ],
                        )),
                  )
                : const Expanded(
                    child: GuestMode(),
                  )
          ],
        );
      },
    );
  }
}

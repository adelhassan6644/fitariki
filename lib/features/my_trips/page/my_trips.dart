import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_app_bar.dart';
import '../../auth/provider/firebase_auth_provider.dart';
import '../../guest/guest_mode.dart';
import '../provider/my_trips_provider.dart';
import '../widgets/my_trip_card.dart';
import '../widgets/tab_bar_widget.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTripsProvider>(
      builder: (_, provider, child) {
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
              provider: provider,
            ),
            Consumer<FirebaseAuthProvider>(
              builder: (context, provider, child) {
                return provider.isLogin
                    ? Expanded(
                        child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                            vertical: 8),
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          MyTripCard(
                            status: "waiting",
                          ),
                          MyTripCard(
                              isCurrent: true, total: "20", userNumber: "2"),
                          MyTripCard(
                            status: "pay",
                          ),
                        ],
                      ))
                    : const Expanded(
                        child: GuestMode(),
                      );
              },
            ),
          ],
        );
      },
    );
  }
}

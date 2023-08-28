import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_app_bar.dart';
import '../provider/my_running_trips_provider.dart';
import '../widgets/my_running_trips_header.dart';
import '../widgets/sub_trip_card.dart';

class MyRunningTripsPage extends StatelessWidget {
  const MyRunningTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRunningTripsProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppBar(
          appBarHeight: 60,
          title: "اليوم ${provider.selectedDay.dateFormat(format: "EEEE")}",
          subTitle: provider.selectedDay.dateFormat(format: "dd MMM, yyyy"),
        ),
        body: const SafeArea(
          top: false,
          child: Column(
            children: [
              MyRunningTripsHeader(),
              SubTripCard(),
            ],
          ),
        ),
      );
    });
  }
}

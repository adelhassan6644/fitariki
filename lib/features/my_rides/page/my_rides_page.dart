import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../provider/my_rides_provider.dart';
import '../widgets/my_rides_header.dart';
import '../widgets/ride_card.dart';

class MyRidesPage extends StatefulWidget {
  const MyRidesPage({Key? key}) : super(key: key);

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<MyRidesProvider>().scroll(controller);
      sl<MyRidesProvider>().rides.clear();
      sl<MyRidesProvider>().onSelectTab(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRidesProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppBar(
          appBarHeight: 60,
          title:
              "${getTranslated("the_day", context)} ${provider.selectedDay.dateFormat(format: "EEEE")}",
          subTitle: provider.selectedDay.dateFormat(format: "dd MMM, yyyy"),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              const MyRidesHeader(),
              Expanded(
                child: Consumer<MyRidesProvider>(builder: (_, provider, child) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await provider.getRides();
                    },
                    color: Styles.PRIMARY_COLOR,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                            controller: controller,
                            data: provider.isLoading
                                ? List.generate(
                                    8,
                                    (index) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 16.0,
                                              left: Dimensions
                                                  .PADDING_SIZE_DEFAULT.w,
                                              right: Dimensions
                                                  .PADDING_SIZE_DEFAULT.w),
                                          child: const CustomShimmerContainer(
                                            height: 115,
                                            radius: 8,
                                          ),
                                        ))
                                : provider.rides.isEmpty
                                    ? [
                                        EmptyState(
                                          emptyHeight: 250,
                                          spaceBtw: 15,
                                          txt: getTranslated(
                                              "there_is_no_rides_on_this_day",
                                              context),
                                          imgHeight: 80,
                                          imgWidth: 80,
                                        )
                                      ]
                                    : List.generate(
                                        provider.rides.length,
                                        (index) => RideCard(
                                              ride: provider.rides[index],
                                          isDriver: provider.isDriver,
                                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

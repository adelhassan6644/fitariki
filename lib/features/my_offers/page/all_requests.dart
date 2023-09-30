import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/my_offers_provider.dart';
import '../widgets/request_card.dart';

class AllRequests extends StatelessWidget {
  const AllRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: sl.get<ProfileProvider>().isDriver
            ? getTranslated("offers", context)
            : getTranslated("requests", context),
        withBorder: true,
      ),
      body: SafeArea(
        top: false,
        child: Consumer<MyOffersProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListAnimator(
                  data: [
                    SizedBox(height: 12.h),
                    ...List.generate(
                        provider.myOfferDetails!.offerRequests!.length,
                        (index) => RequestCard(
                              isDriver: provider.isDriver,
                              request: provider
                                  .myOfferDetails!.offerRequests![index],
                            )),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

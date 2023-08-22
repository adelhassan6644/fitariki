import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/components/custom_app_bar.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_favourite_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../../wishlist/widgets/favourite_user_card.dart';
import '../provider/home_provider.dart';

class AllHomeUsers extends StatelessWidget {
  const AllHomeUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, provider, child) {
      return Scaffold(
        appBar: CustomAppBar(
            title: getTranslated(
                provider.isDriver ? "passengers" : "captains", context)),
        body: SafeArea(
          top: false,
          child: Column(children: [
            const SizedBox(height: 12),
            Expanded(
              child: RefreshIndicator(
                color: Styles.PRIMARY_COLOR,
                onRefresh: () async {
                  await provider.getUsers();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListAnimator(
                        data: provider.isGetting
                            ? List.generate(
                                7, (index) => const ShimmerFavouriteUserCard())
                            : provider.homeUsersModel == null ||
                                    (provider.homeUsersModel!.clients!
                                            .isNotEmpty &&
                                        provider.homeUsersModel!.drivers!
                                            .isNotEmpty)
                                ? [
                                    EmptyState(
                                        txt: getTranslated(
                                            provider.isDriver
                                                ? "there_is_no_clients"
                                                : "there_is_no_drivers",
                                            context))
                                  ]
                                : List.generate(
                                    (provider
                                            .homeUsersModel!.clients!.isNotEmpty
                                        ? provider
                                            .homeUsersModel!.clients!.length
                                        : provider.homeUsersModel!.drivers!
                                                .isNotEmpty
                                            ? provider
                                                .homeUsersModel!.drivers!.length
                                            : 0),
                                    (index) => FavouriteUserCard(
                                        withSaveButton: false,
                                        client: provider.isDriver
                                            ? provider
                                                .homeUsersModel!.clients![index]
                                            : null,
                                        driver: !provider.isDriver
                                            ? provider
                                                .homeUsersModel!.drivers![index]
                                            : null)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}

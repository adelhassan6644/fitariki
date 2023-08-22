import 'package:fitariki/features/wishlist/widgets/favourite_user_card.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_favourite_user_card.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/empty_widget.dart';
import '../provider/home_provider.dart';
import 'home_head_title_widget.dart';

class HomeUsers extends StatelessWidget {
  const HomeUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, provider, child) {
      print(
          "fff${provider.homeUsersModel?.clients?.length ?? provider.homeUsersModel?.drivers?.length ?? 0}");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: !provider.isLogin,
            child: HomeHeadTitleWidget(
              title: getTranslated(
                  provider.isDriver ? "passengers" : "captains", context),
              onTap: () => CustomNavigator.push(Routes.ALL_HOME_USERS),
            ),
          ),
          Column(
            children: provider.isGetting
                ? List.generate(!provider.isLogin ? 2 : 7,
                    (index) => const ShimmerFavouriteUserCard())
                : provider.homeUsersModel == null ||
                        (provider.homeUsersModel!.clients!.isEmpty &&
                            provider.homeUsersModel!.drivers!.isEmpty)
                    ? [
                        EmptyState(
                          txt: getTranslated(
                              provider.isDriver
                                  ? "there_is_no_clients"
                                  : "there_is_no_drivers",
                              context),
                          imgHeight: 80,
                          imgWidth: 80,
                        )
                      ]
                    : List.generate(
                        !provider.isLogin &&
                                (provider.homeUsersModel!.clients!.length > 2 ||
                                    provider.homeUsersModel!.drivers!.length >
                                        2)
                            ? 2
                            : (provider.homeUsersModel!.clients!.isNotEmpty
                                ? provider.homeUsersModel!.clients!.length
                                : provider.homeUsersModel!.drivers!.isNotEmpty
                                    ? provider.homeUsersModel!.drivers!.length
                                    : 0),
                        (index) => FavouriteUserCard(
                            withSaveButton: false,
                            client: provider.isDriver
                                ? provider.homeUsersModel!.clients![index]
                                : null,
                            driver: !provider.isDriver
                                ? provider.homeUsersModel!.drivers![index]
                                : null)),
          ),
        ],
      );
    });
  }
}

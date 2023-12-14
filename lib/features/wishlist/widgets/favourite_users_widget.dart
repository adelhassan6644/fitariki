import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/shimmer_widgets/shimmer_favourite_user_card.dart';
import '../provider/wishlist_provider.dart';
import 'favourite_user_card.dart';

class UsersWidgets extends StatelessWidget {
  const UsersWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListAnimator(
              data: provider.isLoading
                  ? List.generate(
                      5,
                      (index) => const ShimmerFavouriteUserCard(),
                    )
                  : provider.favouriteModel!.drivers!.isNotEmpty ||
                          provider.favouriteModel!.clients!.isNotEmpty
                      ? List.generate(
                          sl<ProfileProvider>().isDriver
                              ? provider.favouriteModel!.clients!.length
                              : provider.favouriteModel!.drivers!.length,
                          (index) => FavouriteUserCard(
                            client: sl<ProfileProvider>().isDriver
                                ? provider.favouriteModel!.clients![index]
                                : null,
                            driver: sl<ProfileProvider>().isDriver
                                ? null
                                : provider.favouriteModel!.drivers![index],
                          ),
                        )
                      : [
                          EmptyState(
                            txt: sl<ProfileProvider>().isDriver
                                ? "لا يوجد ركاب في المحفوظات !"
                                : "لا يوجد كباتن في المحفوظات !",
                          )
                        ]));
    });
  }
}

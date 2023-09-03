import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/tab_widget.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/wishlist_provider.dart';
import '../widgets/favourite_users_widget.dart';
import '../widgets/favourite_offers_widget.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("archives", context),
      ),
      body: SafeArea(
        top: false,
        child: Consumer<WishlistProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Styles.CONTAINER_BACKGROUND_COLOR,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                        children: List.generate(
                      provider.clientTabs.length,
                      (index) => Expanded(
                          child: TabWidget(
                        title: sl.get<ProfileProvider>().isDriver
                            ? getTranslated(provider.driverTabs[index], context)
                            : getTranslated(
                                provider.clientTabs[index], context),
                        isSelected: index == provider.currentTab,
                        onTab: () => provider.selectedTab(index),
                      )),
                    )),
                  )),
              Expanded(child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: ()async{
                          provider.getWishList();
                        },
                      color: Styles.PRIMARY_COLOR,
                        child: Column(children: [
                          if (provider.currentTab == 0) const FavouriteOffersWidgets(),
                          if (provider.currentTab == 1) const UsersWidgets()
                        ],),
                      ),
                  )
                ],
              ))
            ],
          );
        }),
      ),
    );
  }
}

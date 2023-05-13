import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/tab_widget.dart';
import '../provider/wishlist_provider.dart';
import '../widgets/captains_widget.dart';
import '../widgets/delievery_orders_widget.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: getTranslated("archives", context),
            ),
            Consumer<WishlistProvider>(builder: (_, provider, child) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                              color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                              children: List.generate(
                            provider.tabs.length,
                            (index) => Expanded(
                                child: TabWidget(
                              title: getTranslated(provider.tabs[index], context),
                              isSelected: index == provider.currentTab,
                              onTab: () => provider.selectedTab(index),
                            )),
                          )),
                        )),
                    if (provider.currentTab == 0) const DeliveryOrdersWidgets(),
                    if (provider.currentTab == 1) const CaptainsWidgets()
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

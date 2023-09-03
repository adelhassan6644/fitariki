import 'dart:developer';

import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/my_trips/page/my_trips.dart';
import 'package:fitariki/main_page/widget/nav_bar_bar.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_show_model_bottom_sheet.dart';
import '../data/config/di.dart';
import '../data/network/netwok_info.dart';
import '../features/auth/pages/login.dart';
import '../features/home/page/home.dart';
import '../features/home/provider/home_provider.dart';
import '../features/more/page/more.dart';
import '../features/my_offers/page/my_offers.dart';
import '../features/my_offers/provider/my_offers_provider.dart';
import '../features/my_trips/provider/my_trips_provider.dart';
import '../features/post_offer/page/post_offer.dart';
import '../features/post_offer/provider/post_offer_provider.dart';
import '../features/wishlist/provider/wishlist_provider.dart';
import '../main_providers/dashboard_provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({this.index, Key? key}) : super(key: key);
  final int? index;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final PageController _pageController =
      PageController(initialPage: _selectedIndex);
  late int _selectedIndex;
  _setPage(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.index ?? 0;
    Future.delayed(Duration.zero, () => init());
    NetworkInfo.checkConnectivity(onVisible: () {
      Future.delayed(Duration.zero, () => init());
    });
    super.initState();
  }

  init() {
    sl<DashboardProvider>().checkFinishedTrips();
    sl<HomeProvider>().getOffers();
    sl<HomeProvider>().getUsers();
    sl<HomeProvider>().checkRunningTrips();

    if (sl<ProfileProvider>().isLogin) {
      sl<ProfileProvider>().getProfile();
      sl<MyOffersProvider>().getMyOffers();
      sl<WishlistProvider>().getWishList();
      sl<MyTripsProvider>().getCurrentTrips();
      sl<MyTripsProvider>().getPreviousTrips();
      sl<MyTripsProvider>().getPendingTrips();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        bottomNavigationBar: SafeArea(
          bottom: true,
          top: false,
          child: Container(
              height: 60,
              width: context.width,
              decoration: BoxDecoration(
                  color: Styles.WHITE_COLOR,
                  border: Border(
                      top: BorderSide(
                    color: const Color(0xFF3C3C43).withOpacity(0.36),
                    width: 0.5,
                  ))),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BottomNavBarItem(
                        svgIcon: SvgImages.navLogoIcon,
                        isSelected: _selectedIndex == 0,
                        onTap: () => _setPage(0),
                        name: "في طريقي",
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        svgIcon: SvgImages.car,
                        isSelected: _selectedIndex == 1,
                        onTap: () => _setPage(1),
                        name: getTranslated("my_trips", context),
                      ),
                    ),
                    Visibility(
                      visible: provider.isLogin,
                      child: Expanded(
                        child: BottomNavBarItem(
                          svgIcon: SvgImages.delivered,
                          isSelected: _selectedIndex == 2,
                          onTap: () => _setPage(2),
                          name: provider.isLogin
                              ? provider.isDriver
                                  ? getTranslated("delivery_offers", context)
                                  : getTranslated("delivery_requests", context)
                              : getTranslated("offers_or_requests", context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BottomNavBarItem(
                        svgIcon: SvgImages.profileIcon,
                        isSelected: _selectedIndex == 3,
                        onTap: () => _setPage(3),
                        height: 18,
                        width: 18,
                        name: getTranslated("profile", context),
                      ),
                    ),
                  ])),
        ),
        floatingActionButton: Visibility(
          visible: _selectedIndex == 0 && provider.isLogin,
          child: FloatingActionButton(
            onPressed: () {
              if (provider.isLogin) {
                if (provider.isDriver && provider.status != "1") {
                  log(provider.status.toString());
                  CustomSnackBar.showSnackBar(
                      notification: AppNotification(
                          message:
                              "عفواً، لا يمكن اضافة عرض لانه لم يتم تفعيل حسابك بعد",
                          isFloating: true,
                          backgroundColor: Styles.IN_ACTIVE,
                          borderColor: Colors.transparent));
                  return;
                } else {
                  customShowModelBottomSheet(
                    onClose:
                        Provider.of<PostOfferProvider>(context, listen: false)
                            .reset,
                    body: const PostOffer(),
                  );
                }
              } else {
                customShowModelBottomSheet(
                  onClose:
                      Provider.of<PostOfferProvider>(context, listen: false)
                          .reset,
                  body: const Login(),
                );
              }
            },
            backgroundColor: Styles.PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.add,
              size: 24,
              color: Styles.WHITE_COLOR,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Home(),
                    const MyTrips(),
                    Visibility(
                        visible: provider.isLogin, child: const MyOffers()),
                    const More()
                  ]),
            ),
          ],
        ),
      );
    });
  }
}

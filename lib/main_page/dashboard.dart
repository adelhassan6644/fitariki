import 'package:flutter/material.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/my_trips/page/my_trips.dart';
import 'package:fitariki/features/profile/page/profile.dart';
import 'package:fitariki/features/search/page/search.dart';
import 'package:fitariki/main_page/widget/nav_bar_bar.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../app/localization/localization/language_constant.dart';
import '../data/network/netwok_info.dart';
import '../features/home/page/home.dart';

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
    NetworkInfo.checkConnectivity();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      bottomNavigationBar: Container(
          height: 60,
          width: context.width,
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
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
                Expanded(
                  child: BottomNavBarItem(
                    svgIcon: SvgImages.search,
                    isSelected: _selectedIndex == 2,
                    onTap: () => _setPage(2),
                    name: getTranslated("search", context),
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
      body: Column(
        children: [
          Expanded(
            child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [Home(), MyTrips(), Search(), Profile()]),
          ),
        ],
      ),
    );
  }
}

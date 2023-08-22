import 'package:fitariki/features/home/widgets/role_type_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/acceptable_widget.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_offers.dart';
import '../widgets/home_tab_bar_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeAppBar(),
        AcceptableWidget(),
        RoleTypeWidget(),
        HomeTabBarWidget(),
        HomeOffers()
      ],
    );
  }
}

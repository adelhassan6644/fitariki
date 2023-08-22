import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/home/widgets/role_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/config/di.dart';
import '../provider/home_provider.dart';
import '../widgets/acceptable_widget.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_offers.dart';
import '../widgets/home_tab_bar_widget.dart';
import '../widgets/home_users.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, sl<HomeProvider>().scroll(controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const HomeAppBar(),
        const AcceptableWidget(),
        const RoleTypeWidget(),
        const HomeTabBarWidget(),
        Expanded(
          child: Consumer<HomeProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    color: Styles.PRIMARY_COLOR,
                    onRefresh: () async {
                      provider.getOffers();
                      provider.getUsers();
                    },
                    child: ListView(
                      controller: controller,
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: provider.isLogin
                          ? [
                              provider.tab == 0
                                  ? const HomeOffers()
                                  : const HomeUsers()
                            ]
                          : [const HomeOffers(), const HomeUsers()],
                    ),
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

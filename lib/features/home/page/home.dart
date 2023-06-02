import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:fitariki/features/home/widgets/role_type_widget.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../widgets/acceptable_widget.dart';
import '../widgets/home_app_bar.dart';
import '../../../main_widgets/offer_card.dart';
import 'package:fitariki/features/home/widgets/search_bar.dart';

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
        const SearchBarWidget(),
        Consumer<HomeProvider>(builder: (_, homeProvider, child) {
          return Expanded(
            child: RefreshIndicator(
              color: ColorResources.PRIMARY_COLOR,
              onRefresh: () async {
                await homeProvider.getOffers();
              },
              child: ListView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: homeProvider.isLoading
                    ? List.generate(7, (index) => const ShimmerOfferCard())
                    : homeProvider.offer == null || homeProvider.offer!.isEmpty
                        ? [
                            EmptyState(
                                txt: getTranslated(
                                    "there_is_no_delivery_requests_or_delivery_offers",
                                    context))
                          ]
                        : List.generate(
                            homeProvider.offer?.length ?? 0,
                            (index) => OfferCard(
                                offerModel: homeProvider.offer![index])),
              ),
            ),
          );
        })
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

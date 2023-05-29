import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/empty_widget.dart';
import '../../../components/tab_widget.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/acceptable_widget.dart';
import '../widgets/home_app_bar.dart';
import '../../../main_widgets/offer_card.dart';
import 'package:fitariki/features/home/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>   with AutomaticKeepAliveClientMixin<Home>{
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, sl<HomeProvider>().scroll(controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppBar(),
        const AcceptableWidget(),
        Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return provider.isLogin
                ? const SizedBox()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                                color:
                                    ColorResources.CONTAINER_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(6)),
                            child: Consumer<HomeProvider>(
                                builder: (context, provider, child) {
                              return Row(
                                children: List.generate(
                                    provider.titles.length,
                                    (index) => Expanded(
                                          child: TabWidget(
                                              title: getTranslated(
                                                  provider.titles[index],
                                                  context),
                                              isSelected:
                                                  index == provider.roleIndex,
                                              onTab: () =>
                                                  provider.onSelectRole(index)),
                                        )),
                              );
                            })),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  );
          },
        ),
        const SearchBarWidget(),
        Consumer<HomeProvider>(builder: (context, homeProvider, _) {
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
                              txt: getTranslated("there_is_no_delivery_requests_or_delivery_offers", context)
                            )
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
  bool get wantKeepAlive =>true;
}

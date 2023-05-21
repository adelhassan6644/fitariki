import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/shimmer_offer_card.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../components/tab_widget.dart';
import '../../auth/provider/firebase_auth_provider.dart';
import '../widgets/acceptable_widget.dart';
import '../widgets/home_app_bar.dart';
import '../../../main_widgets/offer_card.dart';
import 'package:fitariki/features/home/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // if(LocationHelper.checkLocation()){
    //   Provider.of<LocationProvider>(context,listen: false).getCurrentLocation();
    // }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppBar(),
        const AcceptableWidget(),
        Consumer<FirebaseAuthProvider>(
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
                                builder: (context, provider, child)  {
                                return Row(
                                  children: List.generate(
                                      provider.titles.length,
                                      (index) => Expanded(
                                            child: TabWidget(
                                                title: getTranslated(provider.titles[index], context),
                                                isSelected: index == provider.roleIndex,
                                                onTab: ()=>provider.onSelectRole(index)
                                            ),
                                          )),
                                );
                              }
                            )),
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
              child: ListAnimator(
                data: homeProvider.isLoading
                    ? List.generate(7, (index) => const ShimmerOfferCard())
                    : homeProvider.offer == null || homeProvider.offer!.isEmpty ? [
                  const EmptyState(
                    txt: "لا يوجود عروض توصيل",
                  )
                ]
                    : List.generate(
                        homeProvider.offer?.length??0,
                        (index) => OfferCard(offerModel: homeProvider.offer![index])),
              ),
            ),
          );
        })
      ],
    );
  }
}

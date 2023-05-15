import 'package:fitariki/features/home/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/tab_widget.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_models/weak_model.dart';
import '../../auth/provider/firebase_auth_provider.dart';
import '../../maps/models/address_model.dart';
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
  int currentIndex = 0;
  List<String> titles = ["passenger", "captain"];
  @override
  void initState() {
   Future.delayed(Duration.zero,(){
     Provider.of<HomeProvider>(context,listen: false).getOffers();
   });
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
                            child: Row(
                              children: List.generate(
                                  titles.length,
                                  (index) => Expanded(
                                        child: TabWidget(
                                            title: getTranslated(
                                                titles[index], context),
                                            isSelected: index == currentIndex,
                                            onTab: () => setState(
                                                () => currentIndex = index)),
                                      )),
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
        Expanded(
            child: Consumer<HomeProvider>(
              builder: (context,homeProvider,_) {
                if(homeProvider.isLoading) {
                  return SizedBox();
                } else {
                  return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemCount: 1,
          physics: const BouncingScrollPhysics(), itemBuilder: (BuildContext context, int index) {

                return OfferCard(offerModel:homeProvider.offer![index]
               /* OfferModel(name: "ll",duration: 6,dropOff: LocationModel(latitude: "",longitude: "",address: "aa"),
                    dropOn: LocationModel(latitude: "",longitude: "",address: "aa"),
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    maxPrice: 600,
                    minPrice: 400,
                    driverId: 1,offerType: 1,offerDays: [ WeekModel(
                      id: 6,
                      dayName: "السبت",
                      startTime: DateTime.now(),
                      endTime: DateTime.now(),
                    ),]


                )*/
                );
                },

        );
                }
              }
            ))
      ],
    );
  }
}

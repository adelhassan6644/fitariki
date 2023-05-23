import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../main_widgets/captain_card.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../auth/pages/login.dart';
import '../../profile/provider/profile_provider.dart';
import '../../add_offer/page/add_offer.dart';
import '../widgets/car_details.dart';
import '../widgets/reviews_widget.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: Consumer<ProfileProvider>(builder: (_, profileProvider, child) {
          return Column(
            children: [
              CustomAppBar(
                title: profileProvider.isDriver
                    ? getTranslated("delivery_offer", context)
                    : getTranslated("delivery_request", context),
                withSave: true,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: [
                    Container(
                        color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                        child: const UserCard(
                          withAnalytics: true,
                        )),
                    const MapWidget(),
                    DistanceWidget(
                      isCaptain: profileProvider.isDriver,
                    ),
                    if (!profileProvider.isDriver) const CarDetails(),
                    if (!profileProvider.isDriver) const ReviewsWidget()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 24),
                child: CustomButton(
                  text: profileProvider.isDriver
                      ? getTranslated("add_request", context)
                      : getTranslated("add_offer", context),
                  onTap: () => customShowModelBottomSheet(
                    body: profileProvider.isLogin
                        ? AddOffer(
                            isCaptain: profileProvider.isDriver,
                          )
                        : const Login(),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

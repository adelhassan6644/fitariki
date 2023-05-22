import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/auth/provider/firebase_auth_provider.dart';
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
        child: Column(
          children: [
            CustomAppBar(
              title: getTranslated("delivery_offer", context),
              withSave: true,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                      color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                      child: const CaptainCard(
                        withAnalytics: true,
                      )),
                  const MapWidget(),
                  Consumer<ProfileProvider>(
                    builder: (_, profileProvider, child) {
                      return Column(
                        children: [
                          DistanceWidget(role:profileProvider.role??"client" ,),
                          if (profileProvider.role != "driver")
                            const CarDetails(),
                          if (profileProvider.role != "driver")
                            const ReviewsWidget()
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer<FirebaseAuthProvider>(
              builder: (_, provider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: 24),
                  child: CustomButton(
                    text: getTranslated("offer", context),
                    onTap: () => customShowModelBottomSheet(
                      body: provider.isLogin
                          ? const ReplayOffer()
                          : const Login(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/auth/provider/firebase_auth_provider.dart';
import 'package:fitariki/main_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/custom_show_model_bottom_sheet.dart';
import '../../../main_widgets/offer_widget/captain_card.dart';
import '../../auth/pages/login.dart';
import '../../profile/provider/profile_provider.dart';
import '../../add_offer/page/add_offer.dart';
import '../widgets/car_details.dart';
import '../../../main_widgets/map_widget/map_widget.dart';
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customImageIconSVG(
                                  imageName: SvgImages.sparkles,
                                  color: ColorResources.PRIMARY_COLOR,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  profileProvider.role != "driver"
                                      ? getTranslated(
                                          "the_client_starting_point_is_further_away_from_you",
                                          context)
                                      : getTranslated(
                                          "the_captain_starting_point_is_further_away_from_you",
                                          context),
                                  maxLines: 1,
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                      color: ColorResources.HINT_COLOR,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  " 2.5 كيلو ",
                                  maxLines: 1,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 10,
                                      color: ColorResources.PRIMARY_COLOR,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
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

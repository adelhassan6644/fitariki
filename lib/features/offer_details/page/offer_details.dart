import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/auth/provider/firebase_auth_provider.dart';
import 'package:fitariki/main_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../../../main_widgets/custom_show_model_bottom_sheet.dart';
import '../../../main_widgets/marquee_widget.dart';
import '../../add_offer/page/add_offer.dart';
import '../../auth/pages/login.dart';
import '../../replay_offer/page/replay_offer.dart';
import '../widgets/captain_card.dart';
import '../widgets/car_details.dart';
import '../widgets/map_widget.dart';
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
                  const CaptainCard(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                getTranslated("start_point", context),
                                maxLines: 1,
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              MarqueeWidget(
                                child: Text(
                                  "Al Munsiyah، طريق الامير محمد بن سلمـ...",
                                  maxLines: 1,
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                      color: ColorResources.HINT_COLOR,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                getTranslated("final_destination", context),
                                maxLines: 1,
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              MarqueeWidget(
                                child: Text(
                                  "Al Munsiyah، طريق الامير محمد بن سلمـ...",
                                  maxLines: 1,
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 10,
                                      color: ColorResources.HINT_COLOR,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const MapWidget(),
                  const CarDetails(),
                  const ReviewsWidget()
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
                    onTap: () =>
                        customShowModelBottomSheet(
                          body:provider.isLogin? const ReplayOffer(): const Login(),
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

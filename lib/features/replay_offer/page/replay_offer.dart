import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/bottom_sheet_app_bar.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/replay_offer_provider.dart';
import '../widgets/duration_widget.dart';
import '../widgets/followers_widget.dart';

class ReplayOffer extends StatelessWidget {
  const ReplayOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.9,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppBar(
            title: getTranslated("make_an_offer_to_captain", context),
            textBtn: getTranslated("send", context),
          ),
          Consumer<ReplayOfferProvider>(builder: (_, provider, child) {
            return Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DurationWidget(
                    provider: provider,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer<ProfileProvider>(
                    builder: (_, editProfileProvider, child) {
                      return editProfileProvider.role == "driver"
                          ? const SizedBox()
                          : FollowersWidget(
                              provider: provider,
                            );
                    },
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

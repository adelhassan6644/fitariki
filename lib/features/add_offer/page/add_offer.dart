import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/bottom_sheet_app_bar.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/add_offer_provider.dart';
import '../widgets/offer_information_widget.dart';
import '../widgets/your_location_widget.dart';

class AddOffer extends StatelessWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height - context.toPadding,
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
          Consumer<ProfileProvider>(
            builder: (_, editProfileProvider, child) {
              return BottomSheetAppBar(
                title: editProfileProvider.role == "driver"
                    ? getTranslated("add_a_delivery_offer", context)
                    : getTranslated("add_a_delivery_request", context),
                textBtn: getTranslated("preview", context),
              );
            },
          ),
          Consumer<AddOfferProvider>(builder: (_, provider, child) {
            print(provider.selectedDays.length);
            return Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  YourLocationWidget(provider: provider),
                  OfferInformationWidget(
                    provider: provider,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Consumer<EditProfileProvider>(
                  //   builder: (_, editProfileProvider, child) {
                  //     return editProfileProvider.role == "driver"
                  //         ? const SizedBox()
                  //         : FollowersWidget(
                  //             provider: provider,
                  //           );
                  //   },
                  // )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

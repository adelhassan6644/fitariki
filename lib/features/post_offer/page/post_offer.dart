import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/post_offer/page/preview_offer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/followers_widget.dart';
import '../../profile/provider/profile_provider.dart';
import '../provider/post_offer_provider.dart';
import '../widgets/offer_information_widget.dart';
import '../widgets/your_location_widget.dart';

class PostOffer extends StatelessWidget {
  const PostOffer({Key? key}) : super(key: key);

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
      child: Consumer<PostOfferProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetAppBar(
                title: sl.get<ProfileProvider>().isDriver
                    ? getTranslated("add_a_delivery_request", context)
                    : getTranslated("add_a_delivery_offer", context),
                textBtn: getTranslated("preview", context),
                onTap: () {
                  if (provider.checkData() == true) {
                    customShowModelBottomSheet(
                      body: const PreviewOffer(),
                    );
                  }
                }),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  YourLocationWidget(provider: provider),
                  OfferInformationWidget(
                    provider: provider,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (!sl.get<ProfileProvider>().isDriver)
                    const FollowersWidget(),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

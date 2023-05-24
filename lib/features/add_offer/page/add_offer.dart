import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../main_widgets/followers_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/add_offer_provider.dart';
import '../widgets/duration_widget.dart';

class AddOffer extends StatelessWidget {
  const AddOffer({ required this.isCaptain,Key? key, required this.tripID}) : super(key: key);
final bool isCaptain ;
final int tripID ;
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
      child: Consumer<AddOfferProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetAppBar(
              title: isCaptain
                  ? getTranslated("make_a_request_to_client", context)
                  : getTranslated("make_an_offer_to_captain", context),
              textBtn: getTranslated("send", context),
              onTap: () {
                provider.requestOffer(tripID:tripID);

              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  DurationWidget(
                    provider: provider,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if(!isCaptain)const FollowersWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                /*  CustomTextFormField(
                      label: true,
                      inputType: TextInputType.text,
                      hint: getTranslated("add_a_note", context),
                      maxLine: 5,
                      minLine: 1,
                      onChanged: (v) {
                        provider.note = v;
                      }),*/
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

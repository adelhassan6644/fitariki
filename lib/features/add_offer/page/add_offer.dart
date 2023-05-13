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
import '../../profile/provider/profile_provider.dart';
import '../provider/add_offer_provider.dart';
import '../widgets/duration_widget.dart';

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
          Consumer<ProfileProvider>(
            builder: (_, profileProvider, child) {
              return BottomSheetAppBar(
                title: profileProvider.role == "driver"
                    ? getTranslated("make_an_offer_to_client", context)
                    : getTranslated("make_an_offer_to_captain", context),
                textBtn: getTranslated("send", context),
                onTap: (){
                  CustomNavigator.push(Routes.SUCCESS_POST, replace: true,arguments: "محمد");
                },
              );
            },
          ),
          Consumer<AddOfferProvider>(builder: (_, provider, child) {
            return Expanded(
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
                  Consumer<ProfileProvider>(
                    builder: (_, profileProvider, child) {
                      return profileProvider.role == "driver"
                          ? const SizedBox()
                          : const FollowersWidget();
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                      label: true,
                      inputType: TextInputType.text,
                      hint: getTranslated("add_a_note", context),
                      maxLine: 5,
                      minLine: 1,
                      onChanged: (v) {
                        provider.note = v;
                      }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

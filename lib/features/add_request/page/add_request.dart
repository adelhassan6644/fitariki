import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_widgets/calender_widget.dart';
import '../../../main_widgets/followers_widget.dart';
import '../provider/add_request_provider.dart';
import '../widgets/duration_widget.dart';

class AddRequest extends StatelessWidget {
  const AddRequest(
      {required this.isCaptain,
      Key? key,
      required this.offer,
      required this.name})
      : super(key: key);
  final bool isCaptain;
  final OfferModel offer;
  final String name;
  @override
  Widget build(BuildContext context) {
    ///to update days
    sl<AddRequestProvider>().updateOfferDays(offer.offerDays!.map((e) => e.id!).toList());
    return Container(
      height: context.height * 0.9,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Consumer<AddRequestProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetAppBar(
              title: isCaptain
                  ? getTranslated("make_an_offer_to_client", context)
                  : getTranslated("make_a_request_to_captain", context),
              textBtn: getTranslated("send", context),
              onTap: () {
                if (provider.checkData(
                        minOfferPrice: offer.minPrice ?? 0,
                        maxOfferPrice: offer.maxPrice ?? 0) ==
                    true) {
                  provider.requestOffer(tripID: offer.id, name: name);
                }
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
                  if (!isCaptain) const FollowersWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  CalenderWidget(
                      startDate: provider.startDate,
                      endDate: provider.endDate,
                      days: offer.offerDays!)

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

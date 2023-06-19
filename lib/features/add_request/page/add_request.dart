import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_widgets/calender_widget.dart';
import '../../../main_widgets/followers_widget.dart';
import '../provider/add_request_provider.dart';
import '../widgets/duration_widget.dart';

class AddRequest extends StatefulWidget {
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
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AddRequestProvider>(context, listen: false)
          .updateOfferDays(widget.offer.offerDays!.map((e) => e.id!).toList());
      Provider.of<AddRequestProvider>(context, listen: false).startDate =
          widget.offer.startDate ?? DateTime.now();
      Provider.of<AddRequestProvider>(context, listen: false).endDate =
          widget.offer.endDate ?? DateTime.now();
    });
    super.initState();
  }

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
      child: Consumer<AddRequestProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetAppBar(
              title: widget.isCaptain
                  ? getTranslated("make_an_offer_to_client", context)
                  : getTranslated("make_a_request_to_captain", context),
              textBtn: getTranslated("send", context),
              onTap: () {
                if (provider.checkData(
                        minOfferPrice: widget.offer.minPrice ?? 0,
                        maxOfferPrice: widget.offer.maxPrice ?? 0) ==
                    true) {
                  provider.requestOffer(
                      tripID: widget.offer.id, name: widget.name);
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
                    offerStartDate: widget.offer.startDate ?? DateTime.now(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (!widget.isCaptain) const FollowersWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  CalenderWidget(
                      startDate: provider.startDate,
                      endDate: provider.endDate,
                      days: widget.offer.offerDays!)
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

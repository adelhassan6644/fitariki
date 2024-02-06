import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/methods.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/bottom_sheet_app_bar.dart';
import '../../../data/config/di.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_models/weak_model.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../main_widgets/calender_widget.dart';
import '../../../main_widgets/followers_widget.dart';
import '../provider/add_request_provider.dart';
import '../widgets/duration_widget.dart';

class AddRequest extends StatefulWidget {
  const AddRequest(
      {required this.isCaptain,
      Key? key,
      this.isSpecialOffer = false,
      this.offer,
      this.updateOfferDetails,
      this.senderId,
      required this.name,
      required this.days})
      : super(key: key);
  final bool isCaptain;
  final bool isSpecialOffer;
  final OfferModel? offer;
  final ValueChanged? updateOfferDetails;
  final int? senderId;
  final List<WeekModel> days;
  final String name;

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<AddRequestProvider>().updateOfferDays(widget.days);
      if (!widget.isSpecialOffer && widget.offer != null) {
        if (widget.offer!.startDate!.isBefore(DateTime.now())) {
          sl<AddRequestProvider>()
              .onSelectStartDate(widget.offer?.startDate ?? DateTime.now());
        } else {
          sl<AddRequestProvider>().onSelectStartDate(DateTime.now());
        }
        sl<AddRequestProvider>()
            .onSelectEndDate(widget.offer?.endDate ?? DateTime.now());
      }
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
              title: widget.isSpecialOffer
                  ? getTranslated("add_special_offer", context)
                  : widget.isCaptain
                      ? getTranslated("make_an_offer_to_client", context)
                      : getTranslated("make_a_request_to_captain", context),
              textBtn: getTranslated("send", context),
              onTap: () {
                if (provider.checkData(
                        minOfferPrice: widget.offer?.minPrice ?? 0,
                        maxOfferPrice: widget.offer?.maxPrice ?? 0,
                        isSpecialOffer: widget.isSpecialOffer) ==
                    true) {
                  if (!Methods.listEquals(
                    a: widget.offer?.offerDays ?? [],
                    b: sl.get<ScheduleProvider>().selectedDays,
                  )) {
                    CupertinoPopUpHelper.showCupertinoPopUp(
                        confirmTextButton: getTranslated("confirm", context),
                        onConfirm: () {
                          CustomNavigator.pop();
                          provider.requestOffer(
                              updateOffer: widget.updateOfferDetails,
                              id: widget.isSpecialOffer
                                  ? widget.senderId
                                  : widget.offer?.id,
                              name: widget.name,
                              isSpecialOffer: widget.isSpecialOffer);
                        },
                        title: getTranslated(
                            widget.isCaptain
                                ? "table_don't_match"
                                : "days_don't_match",
                            context),
                        description:
                            "${getTranslated(widget.isCaptain ? "working_days_different_partially" : "working_days_do_not_match", context)}"
                            "${getTranslated(widget.isCaptain ? "client" : "captain", context)} ${widget.offer?.driverModel?.firstName ?? widget.offer?.clientModel?.firstName},"
                            " ${getTranslated(widget.isCaptain ? "are_you_sure_to_provide_the_service" : "are_you_sure_to_submit_the_request", context)}");
                  } else {
                    provider.requestOffer(
                        updateOffer: widget.updateOfferDetails,
                        id: widget.isSpecialOffer
                            ? widget.senderId
                            : widget.offer?.id,
                        name: widget.name,
                        isSpecialOffer: widget.isSpecialOffer);
                  }
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
                    offerStartDate: widget.offer?.startDate ?? DateTime.now(),
                  ),

                  ///Followers Widget
                  Visibility(
                    visible: !widget.isCaptain,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: FollowersWidget(),
                    ),
                  ),

                  ///Calender
                  Consumer<ScheduleProvider>(
                      builder: (_, scheduleProvider, child) {
                    return CalenderWidget(
                        startDate: provider.startDate,
                        endDate: provider.endDate,
                        fromAddRequest: true,
                        days: widget.days);
                  })
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

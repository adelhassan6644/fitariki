import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/my_rides/provider/my_rides_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';

class CancelPopUpButton extends StatelessWidget {
  const CancelPopUpButton(
      {super.key,
      required this.id,
      required this.number,
      required this.name,
      required this.day});
  final int number, id;
  final String name;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRidesProvider>(builder: (c, provider, child) {
      return PopupMenuButton(
        onSelected: (v) {
          CupertinoPopUpHelper.showCupertinoPopUp(
              confirmTextButton: getTranslated("yes", context),
              onConfirm: () {
                provider.cancelRide(id);
              },
              title: "التغييب عن #مشوار_$number",
              description: provider.isDriver
                  ? "هل سوف تتغيب عن ارجاع $name في يوم ${day.dateFormat(format: "d MMM yyyy")}؟"
                  : "هل سوف تتغيب عن العودة مع الكابتن $name في يوم ${day.dateFormat(format: "d MMM yyyy")}؟ ");
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              getTranslated("missed_a_ride", context),
              style: AppTextStyles.w400
                  .copyWith(fontSize: 11, color: Styles.SECOUND_PRIMARY_COLOR),
            ),
          ),
        ],
        padding: const EdgeInsets.all(0),
        surfaceTintColor: Colors.white,
        child: const Icon(Icons.more_horiz),
      );
    });
  }
}

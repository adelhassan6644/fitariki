import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../navigation/custom_navigation.dart';

class CancelPopUpButton extends StatelessWidget {
  const CancelPopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (v) {
        CupertinoPopUpHelper.showCupertinoPopUp(
            textButton: getTranslated("yes", context),
            onConfirm: () {
              CustomNavigator.pop();
            },
            title: "التغييب عن #مشوار_1",
            description:
                "هل سوف تتغيب عن العودة مع الكابتن محمد في يوم الثلاثاء تاريخ 22-9-2023 ؟");
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
  }
}

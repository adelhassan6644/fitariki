import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../provider/report_provider.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({this.userId, this.reservationId, Key? key})
      : super(key: key);
  final int? userId, reservationId;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(builder: (_, reportProvider, child) {
      return InkWell(
        onTap: () {
          if (userId != null && reservationId != null) {
            CupertinoPopUpHelper.showCupertinoTextController(
              title: getTranslated("report", context),
              description: getTranslated("report_description", context),
              hint: getTranslated("report_hint", context),
              controller: reportProvider.report,
              keyboardType: TextInputType.text,
              onSend: () => reportProvider.sendReport(
                  userId: userId!, reservationId: reservationId!),
            );
          }
        },
        child: customImageIconSVG(
            imageName: SvgImages.report,
            width: 24,
            height: 24,
            color: Styles.SECOUND_PRIMARY_COLOR),
      );
    });
  }
}

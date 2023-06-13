import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/loading_dialog.dart';
import '../../../navigation/routes.dart';
import '../../success/model/success_model.dart';
import '../repo/report_repo.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepo reportRepo;
  ReportProvider({
    required this.reportRepo,
  });

  TextEditingController report = TextEditingController();

  sendReport({required int reservationId, required int userId}) async {
    if (report.text.isNotEmpty && report.text != "") {
      try {
        CustomNavigator.pop();
        spinKitDialog();
        notifyListeners();
        final response = await reportRepo.sendReport(
          userId: userId,
          reservationId: reservationId,
          report: report.text.trim(),
        );
        response.fold((fail) {
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }, (response) {
          CustomNavigator.pop();
          CustomNavigator.push(Routes.SUCCESS,
              arguments: SuccessModel(
                  isCongrats: false,
                  description: getTranslated("report_success_message",
                      CustomNavigator.navigatorState.currentContext!)));
        });
        report.clear();
        notifyListeners();
      } catch (e) {
        report.clear();
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }
    } else {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("report_validation",
                  CustomNavigator.navigatorState.currentContext!),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }
}

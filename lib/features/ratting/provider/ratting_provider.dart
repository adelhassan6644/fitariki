import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/routes.dart';
import '../repo/ratting_repo.dart';

class RattingProvider extends ChangeNotifier {
  final RattingRepo repo;
  RattingProvider({required this.repo});

  bool get isDriver => repo.isDriver();

  TextEditingController feedback = TextEditingController();
  int ratting = -1;
  selectedRate(value) {
    ratting = value;
    notifyListeners();
  }

  clear() {
    feedback.clear();
    ratting = -1;
  }

  bool isLoading = false;

  sendRate(id) async {
    if (ratting != -1) {
      try {
        isLoading = true;
        notifyListeners();
        final Either<ServerFailure, Response> response = await repo.sendRate(
          id: id,
          rating: (ratting + 1),
        );
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }, (response) {
          CustomNavigator.push(Routes.DASHBOARD, arguments: 0, clean: true);
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("your_feedback_sent_successfully",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
          clear();
        });
        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }
    } else {
      showToast(getTranslated("please_enter_your_feedback",
          CustomNavigator.navigatorState.currentContext!));
    }
  }
}

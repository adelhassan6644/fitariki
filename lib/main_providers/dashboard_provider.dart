import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/components/loading_dialog.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../features/success/model/success_model.dart';
import '../main_repos/dashboard_repo.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardRepo repo;
  DashboardProvider({required this.repo});

  bool get isDriver => repo.isDriver();
  bool get isLogin => repo.isLoggedIn();

  checkFinishedTrips() async {
    if (isLogin) {
      try {
        Either<ServerFailure, Response> response =
            await repo.checkExpiredContracts();
        response.fold((l) {
          showToast(l.error);
        }, (success) {
          if (success.data["data"] != null) {
            showRateTripPopUp(
                success.data["data"]["id"], success.data["data"]["name"]);
          }
        });
        notifyListeners();
      } catch (e) {
        showToast(e.toString());
        notifyListeners();
      }
    }
  }
  checkFinishedRides() async {
    if (isLogin) {
      try {
        Either<ServerFailure, Response> response =
            await repo.checkFinishedRides();
        response.fold((l) {
          showToast(l.error);
        }, (success) {

          if (success.data["data"] != null) {

            CustomNavigator.push(Routes.RATE_RIDE,
                arguments: {
                  "id": success.data["data"]["id"],
                  "name": success.data["data"]["name"],
                  "number": success.data["data"]["remaining_number"]?? 0
                },
                clean: true);
          }
        });
        notifyListeners();
      } catch (e) {
        showToast(e.toString());
        notifyListeners();
      }
    }
  }

  TextEditingController reasonTEC = TextEditingController();

  showRateTripPopUp(id, name) {
    Future.delayed(
        Duration.zero,
        () => CupertinoPopUpHelper.showCupertinoTextController(
              title:
                  "${getTranslated("your_contract_ended_with", CustomNavigator.navigatorState.currentContext!)} $name",
              description: getTranslated(
                  "are_you_generally_satisfied_with_the_trip",
                  CustomNavigator.navigatorState.currentContext!),
              hint: getTranslated(
                  "if_your_answer_is_no_we_would_like_to_know_why",
                  CustomNavigator.navigatorState.currentContext!),
              controller: reasonTEC,
              keyboardType: TextInputType.text,
              sendText: getTranslated(
                  "yes", CustomNavigator.navigatorState.currentContext!),
              cancelText: getTranslated(
                  "no", CustomNavigator.navigatorState.currentContext!),
              onSend: () => sendRateFinishedTrip(id: id, approve: 1),
              onCancel: () {
                if (reasonTEC.text.trim().isNotEmpty) {
                  sendRateFinishedTrip(
                      id: id, approve: 2, reason: reasonTEC.text.trim());
                } else {
                  showToast(
                    getTranslated("please_enter_the_reason",
                        CustomNavigator.navigatorState.currentContext!),
                  );
                }
              },
              onClose: () => reasonTEC.clear(),
            ));
  }

  sendRateFinishedTrip(
      {required int id, required int approve, String? reason}) async {
    try {
      CustomNavigator.pop();
      Future.delayed(Duration.zero, () => spinKitDialog());
      Either<ServerFailure, Response> response = await repo
          .sendExpiredContractRate(id: id, approve: approve, reason: reason);
      response.fold((l) {
        CustomNavigator.pop();
        showToast(l.error);
      }, (success) {
        CustomNavigator.push(
          Routes.SUCCESS,
          replace: true,
          arguments: SuccessModel(
            isPopUp: true,
            isInform: true,
            title: getTranslated("your_contract_ended",
                CustomNavigator.navigatorState.currentContext!),
            onTap: () => CustomNavigator.push(Routes.DASHBOARD,
                arguments: 0, clean: true),
            description: getTranslated(
                "we_hope_that_you_always_have_pleasant_trips",
                CustomNavigator.navigatorState.currentContext!),
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
      showToast(e.toString());
      notifyListeners();
    }
  }
}

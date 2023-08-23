import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/notifications_model.dart';
import '../repo/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsRepo notificationsRepo;

  NotificationsProvider({
    required this.notificationsRepo,
  });

  int tab = 0;
  List<String> tabs = ["delivery_offers", "delivery_requests"];
  onSelectTab(v) {
    tab = v;
    notifyListeners();
  }

  NotificationsModel? notificationsModel;
  bool isLoading = false;
  getNotifications() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await notificationsRepo.getNotification();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        notificationsModel = NotificationsModel.fromJson(response.data);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  updateNotifications() async {
    try {
      Either<ServerFailure, Response> response =
          await notificationsRepo.getNotification();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (response) {
        notificationsModel = NotificationsModel.fromJson(response.data);
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  readNotification(id) async {
    try {
      Either<ServerFailure, Response> response =
          await notificationsRepo.readNotification(id);
      response.fold((l) {
        showToast(ApiErrorHandler.getMessage(l));
        notifyListeners();
      }, (response) {});
    } catch (e) {
      showToast(getTranslated("something_went_wrong",
          CustomNavigator.navigatorState.currentContext!));
      notifyListeners();
    }
  }

  deleteNotification(id) async {
    try {
      notificationsModel!.notifications!.removeWhere((e) => e.id == id);
      notifyListeners();
      Either<ServerFailure, Response> response =
          await notificationsRepo.deleteNotification(id);
      response.fold((l) async {
        await updateNotifications();
        showToast(ApiErrorHandler.getMessage(l));
        notifyListeners();
      }, (response) async {
        await updateNotifications();
        showToast(
          getTranslated("notification_deleted_successfully",
              CustomNavigator.navigatorState.currentContext!),
        );
        notifyListeners();
      });
    } catch (e) {
      await updateNotifications();
      showToast(
        getTranslated("something_went_wrong",
            CustomNavigator.navigatorState.currentContext!),
      );
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
                backgroundColor: ColorResources.IN_ACTIVE,
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
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  readNotification(id) async {
    try {
      Either<ServerFailure, Response> response =
          await notificationsRepo.readNotification(id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (response) {});
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}

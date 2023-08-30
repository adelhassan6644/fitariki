import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/transactions/repo/transactions_repo.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/transactions_model.dart';

class TransactionsProvider extends ChangeNotifier {
  final TransactionsRepo transactionsRepo;

  TransactionsProvider({
    required this.transactionsRepo,
  });

  int tab = 0;
  List<String> tabs = ["current", "finished"];
  onSelectTab(v) {
    tab = v;
    notifyListeners();
  }

  TransactionsModel? currentTransactions;
  bool isGetCurrent = false;
  getCurrentTransactions() async {
    try {
      currentTransactions = null;
      isGetCurrent = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await transactionsRepo.getTransactions(tabs[0]);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isGetCurrent = false;
        notifyListeners();
      }, (response) {
        currentTransactions = TransactionsModel.fromJson(response.data);
        isGetCurrent = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetCurrent = false;
      notifyListeners();
    }
  }

  TransactionsModel? previousTransactions;
  bool isGetPrevious = false;
  getPreviousTransactions() async {
    try {
      previousTransactions = null;
      isGetPrevious = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await transactionsRepo.getTransactions(tabs[1]);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isGetPrevious = false;
        notifyListeners();
      }, (response) {
        previousTransactions = TransactionsModel.fromJson(response.data);
        isGetPrevious = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetPrevious = false;
      notifyListeners();
    }
  }
}

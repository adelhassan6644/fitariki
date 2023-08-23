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
  List<String> tabs = ["the_running", "the_previous"];
  onSelectTab(v) {
    tab = v;
    notifyListeners();
  }

  TransactionsModel? transactionsModel;
  bool isLoading = false;
  getTransactions() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await transactionsRepo.getTransactions();
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
        transactionsModel = TransactionsModel.fromJson(response.data);
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
}

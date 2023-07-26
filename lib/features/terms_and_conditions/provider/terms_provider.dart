import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/terms_and_conditions/repo/terms_repo.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class TermsProvider extends ChangeNotifier {
  final TermsRepo termsRepo;

  TermsProvider({required this.termsRepo}) {
    getTerms();
  }

  bool isLoading = false;
  String? termsForDriver;
  String? termsForClient;
  getTerms() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await termsRepo.getTerms();
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
        termsForDriver = response.data["data"]['settings'][0]['termsForDriver'];
        termsForClient = response.data["data"]['settings'][0]['termsForClient'];
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
}

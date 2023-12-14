import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/error/failures.dart';
import '../features/feedback/model/feedback_model.dart';
import '../features/feedback/repo/feedback_repo.dart';

class ReviewsProvider extends ChangeNotifier {
  FeedbackRepo repo;
  ReviewsProvider({required this.repo});

  bool get isDriver => repo.isDriver();

  bool isGetting = false;
  FeedbackModel? offerFeedback;
  getReviews({required id, required bool ifOffer}) async {
    try {
      isGetting = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getReviews(id, ifOffer);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (res) {
        offerFeedback = FeedbackModel.fromJson(res.data);
      });
      isGetting = false;
      notifyListeners();
    } catch (e) {
      // CustomSnackBar.showSnackBar(
      //     notification: AppNotification(
      //         message: e.toString(),
      //         isFloating: true,
      //         backgroundColor: Styles.IN_ACTIVE,
      //         borderColor: Colors.transparent));
      isGetting = false;
      notifyListeners();
    }
  }
}

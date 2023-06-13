import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/feedback/model/feedback_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../repo/feedback_repo.dart';

class FeedbackProvider extends ChangeNotifier {
  final FeedbackRepo feedbackRepo;
  FeedbackProvider({
    required this.feedbackRepo,
  }) {
    ratting = -1;
  }

  bool isLoading = false;
  FeedbackModel? feedbackModel;
  getFeedback() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await feedbackRepo.getFeedback();
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (res) {
        feedbackModel = FeedbackModel.fromJson(res.data);
      });
      isLoading = false;
      notifyListeners();
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

  TextEditingController feedback = TextEditingController();
  int? ratting;
  selectedRate(value) {
    ratting = value;
    notifyListeners();
  }

  clear() {
    feedback.clear();
    ratting = -1;
  }

  bool isSendFeedback = false;

  sendFeedback({required int offerId, required int userId}) async {
    if (feedback.text.trim().isNotEmpty && ratting != -1) {
      try {
        isSendFeedback = true;
        notifyListeners();
        final response = await feedbackRepo.sendFeedback(
          userId: userId,
          offerId: offerId,
          rating: ratting!,
          feedback: feedback.text.trim(),
        );
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }, (response) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("your_feedback_sent_successfully",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: ColorResources.ACTIVE,
                  borderColor: Colors.transparent));
          clear();
          CustomNavigator.pop();
        });
        isSendFeedback = false;
        notifyListeners();
      } catch (e) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isSendFeedback = false;
        notifyListeners();
      }
    } else {
      showToast(
          getTranslated("please_enter_your_feedback",
              CustomNavigator.navigatorState.currentContext!),
          backGroundColor: ColorResources.IN_ACTIVE);
    }
  }
}

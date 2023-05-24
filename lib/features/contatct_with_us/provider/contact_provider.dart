import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../model/contact_model.dart';
import '../repo/contact_repo.dart';

class ContactProvider extends ChangeNotifier {
  ContactRepo contactRepo;
  ContactProvider({required this.contactRepo});

  ///Get contact Data
  bool isLoading = false;
  ContactModel? contactModel;
  getContact() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await contactRepo.getContact();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        contactModel = ContactModel.fromJson(response.data['data']["contact"]);
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

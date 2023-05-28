import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../repo/ratting_repo.dart';

class RattingProvider extends ChangeNotifier {

  final RattingRepo rattingRepo;
  RattingProvider({required this.rattingRepo,}){
    rate=-1;
  }

  TextEditingController rateMessage = TextEditingController();
  int? rate;
  selectedRate(value){
    rate=value;
    notifyListeners();
  }
  bool isSendRate = false;
  bool isLoading = false;



  getRatting() async {
    try {
      isLoading= true;
      notifyListeners();
      final response = await rattingRepo.getRatting();
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
                message: "Success",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));

      });
      isLoading= false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading= false;
      notifyListeners();
    }
  }


  sendRate({required int id}) async {
    try {
     isSendRate=true;
      notifyListeners();
      final response = await rattingRepo.sendRate(id: id,rate: rate!, rateMessage: rateMessage.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        rateMessage.clear();
        rate=null;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "Success",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
      });
     isSendRate=false;
     notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isSendRate=false;
      notifyListeners();
    }
  }

}

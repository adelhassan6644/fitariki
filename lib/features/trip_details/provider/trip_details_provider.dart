import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../profile/provider/profile_provider.dart';
import '../../success/model/success_model.dart';
import '../repo/trip_details_repo.dart';

class TripDetailsProvider extends ChangeNotifier {

  final TripDetailsRepo tripDetailsRepo;
  TripDetailsProvider({required this.tripDetailsRepo,});

  TextEditingController negotiationPrice = TextEditingController(text: "");
  bool isAccepting = false;
  bool isNegotiation = false;
  bool isRejecting = false;



  updateRequest({required int status, required int id,}) async {
    try {
      if(status == 1){
        isAccepting= true;
      }
      else if(status ==2){
        isNegotiation = true;
      }
      else{
        isRejecting = true;
      }
      notifyListeners();
      final response = await tripDetailsRepo.updateRequest(status: status, id: id,offerPrice: negotiationPrice.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        negotiationPrice.clear();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "Success",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
        if(status == 1) {
          if (!sl.get<ProfileProvider>().isDriver) {
            CustomNavigator.push(Routes.PAYMENT,);
          } else {
            CustomNavigator.push(Routes.SUCCESS,
                replace: true,
                arguments: SuccessModel(
                    isCongrats: true,
                    routeName: Routes.DASHBOARD,
                    argument: 1,
                    isClean: true,
                    title: "أمل ب...",
                    btnText: getTranslated("my_trips",
                        CustomNavigator.navigatorState.currentContext!),
                    description: "تم قبول عرض من أمل ب... بإنتظار الدفع ..."));
          }
        }else{
          CustomNavigator.pop();
        }
      });
      if(status == 1){
        isAccepting= false;
      }
      else if(status ==2){
        isNegotiation = false;
      }
      else{
        isRejecting = false;
      }
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      if(status == 1){
        isAccepting= false;
      }
      else if(status ==2){
        isNegotiation = false;
      }
      else{
        isRejecting = false;
      }
      notifyListeners();
    }
  }

}

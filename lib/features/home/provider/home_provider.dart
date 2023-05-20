import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../maps/models/location_model.dart';
import '../repo/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  // int userTypeIndex = 0;
  // List<String> users = ["passenger", "captain"];
  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];
  int _gender = 0;
  int get gender => _gender;
  selectedGender(int value) {
    _gender = value;
    notifyListeners();
  }

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;

    notifyListeners();
  }

  LocationModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  reset(){
    startLocation=endLocation =null;
    _gender=0;
    notifyListeners();
  }



  bool isLoading = false;
  List<OfferModel>? offer;
  getOffers() async {
    try {


      offer = [];
      isLoading = true;
      notifyListeners();

      final filters = {
        "fillters": {
        if(endLocation != null)  "drop_off_location": endLocation!.toJson(),
          if(startLocation != null) "pickup_location": startLocation!.toJson(),
          "role": gender,
        }
      };

      Either<ServerFailure, Response> response = await homeRepo.getOffer(filters);
      response.fold((l) => null, (response) {
        offer = List<OfferModel>.from(response.data["data"]["offers"]!
            .map((x) => OfferModel.fromJson(x)));
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}

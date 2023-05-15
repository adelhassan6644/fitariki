import 'package:flutter/cupertino.dart';

import '../../../../app/core/utils/svg_images.dart';
import '../../../maps/models/address_model.dart';
import '../repo/follower_details_repo.dart';

class FollowerDetailsProvider extends ChangeNotifier {
  FollowerDetailsRepo followerDetailsRepo;
  FollowerDetailsProvider({required this.followerDetailsRepo});

  String? age, followerFullName;
  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];
  int _gender = 0;
  int get gender => _gender;
  selectedGender(int value) {
    _gender = value;
    notifyListeners();
  }

  bool sameHomeLocation = true;
  void onSelect(bool value) {
    sameHomeLocation = value;
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

  bool sameDestination = true;
  void onSelect1(bool value) {
    sameDestination = value;
    notifyListeners();
  }
}

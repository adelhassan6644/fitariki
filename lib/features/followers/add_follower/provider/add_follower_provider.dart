import 'package:flutter/cupertino.dart';

import '../../../../app/core/utils/svg_images.dart';
import '../../../maps/models/address_model.dart';
import '../repo/add_follower_repo.dart';

class AddFollowerProvider extends ChangeNotifier {
  AddFollowersRepo addFollowersRepo;
  AddFollowerProvider({required this.addFollowersRepo});

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


  reset(){
    followerFullName=null;
    age=null;
    _gender=0;
    startLocation =null;
    endLocation =null;
    sameDestination=true;
    sameHomeLocation=true;
  }
}

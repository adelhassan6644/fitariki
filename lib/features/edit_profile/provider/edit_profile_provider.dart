import 'dart:io';

import 'package:fitariki/features/edit_profile/repo/profile_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/svg_images.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepo editProfileRepo;
  EditProfileProvider({
    required this.editProfileRepo,
  });

  String? firstName;
  String? secondName;
  String? age;
  String? nationality;

  List<String> days = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
  List<String> selectedDays = [];

  onSelectDay(String value) {
    if(selectedDays.contains(value)){
      selectedDays.remove(value);
    }else{
      selectedDays.add(value);
    }
    notifyListeners();
  }

  checkSelectDay(String value) {
    if(selectedDays.contains(value)){
     return true;
    }else{
      return false;
    }
  }

  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];

  int _gender = 0;
  int get gender => _gender;
  void selectedGender(int value) {
    _gender = value;
    notifyListeners();
  }

  List<String> timeZones = ["morning", "night"];
 String startTimeZone ="morning";
  String endTimeZone ="morning";
  void selectedStartTimeZone(String value) {
    startTimeZone = value;
    notifyListeners();
  }
  void selectedEndTimeZone(String value) {
    endTimeZone = value;
    notifyListeners();
  }


  void selectedAge(value) {
    age = value;
    notifyListeners();
  }

  void selectedNationality(value) {
    nationality = value;
    notifyListeners();
  }

  File? profileImage;
  onSelectImage(File? file) {
    profileImage = file;
    notifyListeners();
  }
}

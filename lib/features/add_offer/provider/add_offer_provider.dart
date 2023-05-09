import 'package:flutter/cupertino.dart';

import '../../../main_models/weak_model.dart';
import '../../maps/models/address_model.dart';
import '../repo/add_offer_repo.dart';

class AddOfferProvider extends ChangeNotifier {
  AddOfferRepo addOfferRepo;
  AddOfferProvider({required this.addOfferRepo});

  AddressModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;
    notifyListeners();
  }

  AddressModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  String? minPrice, maxPrice;



  List<WeekModel> selectedDays = [];

  onSelectDay(WeekModel value) {
    if (selectedDays.contains(value)) {
      selectedDays.remove(value);
    } else {
      selectedDays.add(value);
    }
    notifyListeners();
  }

  checkSelectDay(WeekModel value) {
    return selectedDays.indexWhere((element) => element.id == value.id) == -1
        ? false
        : true;
  }

  List<String> timeZones = ["morning", "night"];
  String startTimeZone = "morning";
  String endTimeZone = "morning";
  void selectedStartTimeZone(String value) {
    startTimeZone = value;
    notifyListeners();
  }

  void selectedEndTimeZone(String value) {
    endTimeZone = value;
    notifyListeners();
  }

  DateTime startTime = DateTime.now();
  onSelectStartTime(v) {
    startTime = v;
    notifyListeners();
  }

  DateTime endTime = DateTime.now();
  onSelectEndTime(v) {
    endTime = v;
    notifyListeners();
  }

  DateTime startDate = DateTime.now();
  onSelectStartDate(v) {
    startDate = v;
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  onSelectEndDate(v) {
    endDate = v;
    notifyListeners();
  }

  bool addFollowers = true;
  onChange(v) {
    addFollowers = v;
    notifyListeners();
  }

  List<String> followers = ["محمد احمد", "لؤي احمد", "محمد الفيصل"];
  List<String> selectedFollowers = ["محمد احمد", "لؤي احمد", "محمد الفيصل"];
  onSelectFollow(v, index) {
    if (v) {
      selectedFollowers.add(followers[index]);
    } else {
      selectedFollowers.removeAt(index);
    }
    notifyListeners();
  }
}

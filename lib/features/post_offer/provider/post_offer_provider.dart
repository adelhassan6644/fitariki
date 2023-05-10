import 'package:flutter/cupertino.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../maps/models/address_model.dart';
import '../repo/post_offer_repo.dart';

class PostOfferProvider extends ChangeNotifier {
  PostOfferRepo postOfferRepo;
  final ScheduleProvider scheduleProvider;
  PostOfferProvider({
    required this.postOfferRepo,
    required this.scheduleProvider,
  });

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

  // List<String> timeZones = ["morning", "night"];
  // String startTimeZone = "morning";
  // String endTimeZone = "morning";
  // void selectedStartTimeZone(String value) {
  //   startTimeZone = value;
  //   notifyListeners();
  // }
  //
  // void selectedEndTimeZone(String value) {
  //   endTimeZone = value;
  //   notifyListeners();
  // }

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

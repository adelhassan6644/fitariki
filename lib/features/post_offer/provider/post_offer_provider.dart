import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
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
  List<String> selectedFollowers = [];
  onSelectFollow(v, index) {
    if (v) {
      selectedFollowers.add(followers[index]);
    } else {
      selectedFollowers.removeAt(index);
    }
    notifyListeners();
  }

  reset() {
    startLocation = null;
    endLocation = null;
    startTime = DateTime.now();
    endTime = DateTime.now();
    startDate = DateTime.now();
    endDate = DateTime.now();
    minPrice = null;
    maxPrice = null;
    selectedFollowers.clear();
  }

  checkData() {
    if (startLocation == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الصورةالشخصية!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (scheduleProvider.selectedDays.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الايام!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startTime == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال الاسم الثلاثي!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endTime != startTime) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startDate != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endDate != startDate) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (minPrice != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (maxPrice != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endLocation == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الحنسية!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    return true;
  }
}

import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../data/config/di.dart';
import '../../../main_models/offer_details_model.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';
import '../../success/model/success_model.dart';
import '../repo/post_offer_repo.dart';

class PostOfferProvider extends ChangeNotifier {
  PostOfferRepo postOfferRepo;
  final ScheduleProvider scheduleProvider;
  PostOfferProvider({
    required this.postOfferRepo,
    required this.scheduleProvider,
  });

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;

    notifyListeners();
  }

  OfferDetailsModel? offerModel;
  LocationModel? endLocation;
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
  WeekdayCount? counts;
  onSelectEndDate(v) {
    endDate = v;

    /// get days count
    List<int> days = [];
    for (var element in scheduleProvider.selectedDays) {
      element.startTime = startTime.dateFormat(format: "kk:mm");
      element.endTime = endTime.dateFormat(format: "kk:mm");
      days.add(element.id!);
    }
    counts = Methods.getWeekdayCount(
        startDate: startDate, endDate: endDate, weekdays: days);
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
    minPrice = null;
    maxPrice = null;
    startTime = DateTime.now();
    endTime = DateTime.now();
    startDate = DateTime.now();
    selectedFollowers.clear();
    scheduleProvider.selectedDays.clear();
    onSelectEndDate(DateTime.now());
  }

  checkData() {
    if (startLocation == null) {
      showToast("برجاء اختيار نقطة البدية!");

      return;
    }
    if (scheduleProvider.selectedDays.isEmpty) {
      showToast("برجاء اختيار الايام!");

      return;
    }
    // if (startTime == null) {
    //   showToast( "برجاء ادخال وقت البداية!");
    //   return;
    // }
    if (startTime.isAtSameMomentAs(endTime)) {
      showToast(" وقت النهاية لا يجب ان يكون مثل وقت البداية!");

      return;
    }

    if (startDate.isAtSameMomentAs(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون مثل تاريخ البداية!");

      return;
    }

    if (!startDate.isBefore(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون قبل تاريخ البداية!");

      return;
    }

    if (minPrice == null || minPrice == "") {
      showToast("برجاء اختيار الحد الادني للسعر!");
      return;
    }
    if (maxPrice == null || maxPrice == "") {
      showToast("برجاء اختيار الحد الاعلي للسعر!");

      return;
    }
    if (double.parse(minPrice!) >= double.parse(maxPrice!)) {
      showToast("الحد الاعلي للسعر يجب ان يكون اعلي من الحد الادني للسعر!");

      return;
    }
    if (endLocation == null) {
      showToast("برجاء اختيار نقطة النهاية!");

      return;
    }
    return true;
  }

  bool isLoading = false;
  postOffer() async {
    offerModel = OfferDetailsModel(
      pickLocation: endLocation,
      endLocation: startLocation,
      startDate: startDate,
      endDate: endDate,
      minPrice: double.tryParse(minPrice!),
      maxPrice: double.tryParse(maxPrice!),
      offerDays: scheduleProvider.selectedDays,
      duration: counts!.count,

      // duration:
    );
    print(offerModel?.toPostClientJson());
    isLoading = true;
    notifyListeners();
    final response = await postOfferRepo.postOffer(offerModel: offerModel!);
    response.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (response) {
      CustomNavigator.push(Routes.SUCCESS,
          clean: true,
          arguments: SuccessModel(
              isPopUp: true,
              description: sl<ProfileProvider>().isDriver
                  ? "تم الإرسال بنجاح! \nسيتم تنبيه جميع الكباتن القريبين منك لرفع فرصة اتمام الطلب..."
                  : "تم الإرسال بنجاح! \nسيتم تنبيه جميع الركاب القريبين منك لرفع فرصة اتمام الطلب..."));
      reset();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "Success",
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
    });
    isLoading = false;
    notifyListeners();
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/loading_dialog.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/my_rides_model.dart';
import '../repo/my_rides_repo.dart';

class MyRidesProvider extends ChangeNotifier {
  MyRidesRepo repo;
  MyRidesProvider({required this.repo});

  bool goingDown = false;
  scroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
      } else {
        goingDown = true;
      }
      notifyListeners();
    });
  }

  bool get isDriver => repo.isDriver();

  int selectedTab = 0;
  List<String> tabs = ["go", "back"];
  onSelectTab(v) {
    selectedTab = v;
    notifyListeners();
  }

  CalendarFormat calendarFormat = CalendarFormat.week;
  onChangeFormat(v) {
    calendarFormat = v;
    notifyListeners();
  }

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 5, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 5, DateTime.now().day);

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  void onDaySelected(DateTime sDay, DateTime fDay) {
    selectedDay = sDay;
    focusedDay = fDay;
    getRides();
    notifyListeners();
  }

  List<MyRideModel> rides = [];
  bool isLoading = false;
  getRides() async {
    try {
      rides.clear();
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getRides(
          day: selectedDay, type: tabs[selectedTab].capitalize());
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        if (response.data["data"] != null || response.data["data"] != []) {
          rides = List<MyRideModel>.from(
              response.data["data"].map((x) => MyRideModel.fromJson(x)));
        }
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  cancelRide(id) async {
    try {
      CustomNavigator.pop();
      spinKitDialog();
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.cancelRide(id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        rides.forEach((e) {
          if (e.id == id) {
            e.status = 4;
          }
        });
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: response.data["message"] ?? "",
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      });
      CustomNavigator.pop();
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      CustomNavigator.pop();
      notifyListeners();
    }
  }
}

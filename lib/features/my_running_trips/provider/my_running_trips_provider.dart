import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../repo/my_running_trips_repo.dart';

class MyRunningTripsProvider extends ChangeNotifier {
  MyRunningTripsRepo repo;
  MyRunningTripsProvider({required this.repo});

  int tab = 0;
  List<String> tabs = ["go", "back"];
  onSelectTab(v) {
    tab = v;
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
    notifyListeners();
  }
}

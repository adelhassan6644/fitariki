import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../repo/my_rides_repo.dart';

class MyRidesProvider extends ChangeNotifier {
  MyRidesRepo repo;
  MyRidesProvider({required this.repo});

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

import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

abstract class Methods {
  static diffBtw2Dates({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    var dur = endDate.toLocal().difference(startDate);
    return dur.inDays.toString();
  }

  static WeekdayCount getWeekdayCount(
      {required DateTime startDate,
      required DateTime endDate,
      required List<int> weekdays}) {
    int count = 0;
    int days = 0;

    for (int weekday in weekdays) {
      DateTime currentDate = startDate;
      int daysToWeekday = ((weekday - startDate.weekday) + 7) % 7;

      if (daysToWeekday == 0) {
        count += 1;
        days += 1;
      }

      currentDate = currentDate.add(Duration(days: daysToWeekday));

      while (currentDate.isBefore(endDate)) {
        if (currentDate.weekday == weekday) {
          count += 1;
          days += 1;
        }
        currentDate = currentDate.add(const Duration(days: 7));
      }
    }

    return WeekdayCount(count, days);
  }

  static convertStringToTime(timeString, {bool withFormat = false}) {
    List<String> parts = timeString.split(':');
    TimeOfDay timeOfDay =
        TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
      now.second,
    );
    if (withFormat) {
      return dateTime
          .dateFormat(format: "mm : hh aa")
          .replaceAll("AM", "صباحاً")
          .replaceAll("PM", "مساءً");
    } else {
      return dateTime;
    }
  }

  static getDayCount({
    required DateTime date,
  }) {
    int weeks = 0;
    int days = 0;
    int hour = 0;

    if (DateTime.now().isBefore(date)) {
      weeks = DateTime.now().weekday - date.weekday;
      if (weeks == 0) {
        days = DateTime.now().day - date.day;
        return "$days يوم";
      } else {
        return "$weeks اسبوع";
      }
    } else {
      hour = DateTime.now().hour - date.hour;
      if (hour <= 1) {
        return "ساعة";
      } else if (hour <= 2) {
        return "ساعتين";
      } else if (3 <= hour && hour <= 10) {
        return "$hour ساعات";
      } else if (hour > 10) {
        return "$hour ساعة";
      }
    }
  }
}

class WeekdayCount {
  final int count;
  final int days;

  WeekdayCount(this.count, this.days);
  @override
  String toString() {
    return "cont: $count -- days:$days  ";
  }
}

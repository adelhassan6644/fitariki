import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../features/maps/models/location_model.dart';

abstract class Methods {
  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  static diffBtw2Dates({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    var dur = endDate.toLocal().difference(startDate);
    return dur.inDays.toString();
  }

  static WeekdayCount getWeekdayCount({
    required DateTime startDate,
    required DateTime endDate,
    required List weekdays,
  }) {
    int count = 0;
    int days = 0;
    List<DateTime> daysList = [];

    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      if (weekdays.contains(currentDate.weekday)) {
        daysList.add(currentDate);
        count++;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    days = daysList.length;

    return WeekdayCount(count, days, daysList);
  }




  static String getOfferType(int v) {
    switch (v) {
      case 1:
        return getTranslated(
            "go", CustomNavigator.navigatorState.currentContext!);
      case 2:
        return getTranslated(
            "back", CustomNavigator.navigatorState.currentContext!);
      case 3:
        return getTranslated(
            "go_and_back", CustomNavigator.navigatorState.currentContext!);
    }
    return getTranslated("go", CustomNavigator.navigatorState.currentContext!);
  }

  static convertStringToTime(timeString, {bool withFormat = false}) {
    if (timeString != null) {
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
            .dateFormat(format: "m : h aa")
            .replaceAll("AM", "صباحاً")
            .replaceAll("PM", "مساءً")
            .replaceAll("ص", "صباحاً")
            .replaceAll("م", "مساءً");
      } else {
        return dateTime;
      }
    } else {
      return DateTime.now()
          .dateFormat(format: "m : h aa")
          .replaceAll("AM", "صباحاً")
          .replaceAll("PM", "مساءً")
          .replaceAll("ص", "صباحاً")
          .replaceAll("م", "مساءً");
    }
  }

  static convertStringToDataTime(timeString) {
    List<String> parts = timeString.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      0,
      0,
      0,
    );
  }

  static getDayCount({
    required DateTime date,
  }) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inSeconds < 5) {
      return "الآن";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds} ثانية";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} دقيقة";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ساعة";
    } else if (difference.inDays < 30) {
      return '${difference.inDays} يوم';
    } else {
      return date.defaultFormat();
    }
  }

  static calcDistanceFromCurrentLocation({LocationModel? location}) async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return (Geolocator.distanceBetween(
                currentPosition.latitude,
                currentPosition.longitude,
                double.parse(location?.latitude ?? "0"),
                double.parse(location?.longitude ?? "0")) /
            1000)
        .toStringAsFixed(2);
  }
}

class WeekdayCount {
  final int count;
  final int days;
  final List<DateTime> daysList;

  WeekdayCount(this.count, this.days, this.daysList);
  @override
  String toString() {
    return "cont: $count --days $days  daysList:${daysList}  ";
  }
}

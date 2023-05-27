import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import '../app/core/utils/methods.dart';

class CalenderProvider extends ChangeNotifier {
  WeekdayCount? counts;
  EventList<Event>? _markedDateMap;
  final Widget _eventIcon = Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(.5),
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
    ),
  );
  Map<DateTime, List<Event>> eventsMAP = {};
  EventList<Event>? eventList = EventList<Event>(events: {
    DateTime.now(): [
      Event(
          date: DateTime.now(),
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
            ),
          ))
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+2): [
      Event(
          date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+2),
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
            ),
          ))
    ],
  });
  bool isLoad= false;
  getEventsList() {
    isLoad= true;
    notifyListeners();
    counts = Methods.getWeekdayCount(
        startDate: DateTime.parse('2023-05-29 23:43:56.239050'),
        endDate: DateTime.parse('2023-06-23 23:43:56.239050'),
        weekdays: [1, 2, 3, 4, 5]);

    for (var element in counts!.daysList) {
      {
        // eventsMAP[element]

        eventsMAP[ DateTime(element.year, element.month, element.day) ]  = [Event(date: element, icon: _eventIcon)];
      }



    }
    print(eventsMAP);
    eventList = EventList<Event>(events: eventsMAP);
    isLoad= false;
    notifyListeners();
  }
}

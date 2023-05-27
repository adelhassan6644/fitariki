import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/methods.dart';
import '../main_models/weak_model.dart';

class CalenderWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<WeekModel> days;
  const CalenderWidget(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.days})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _eventIcon = Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
      ),
    );
    final counts = Methods.getWeekdayCount(
        startDate: DateTime.now(),
        endDate:
            DateTime(DateTime.april, DateTime.now().month, DateTime.now().day),
        weekdays: [1, 2]);
    Map<DateTime, List<Event>> eventsMAP={};
    counts.daysList.forEach((element) {

      eventsMAP={ element: [Event(date: element, icon: _eventIcon)],};

    });
    EventList<Event> _markedDateMap = EventList<Event>(
      events: eventsMAP
    );
    print(eventsMAP);
    return CalendarCarousel<Event>(
      weekendTextStyle: const TextStyle(
        color: ColorResources.PRIMARY_COLOR,
      ),
      thisMonthDayBorderColor: Colors.grey,
      // headerText: 'days',
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 480.0,

      selectedDateTime: DateTime.now(),
      showIconBehindDayText: true,

      markedDateShowIcon: true,
      selectedDayTextStyle: const TextStyle(
        color: ColorResources.PRIMARY_COLOR,
      ),
      selectedDayBorderColor: Colors.black12,
      selectedDayButtonColor: Colors.transparent,
      todayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      markedDateIconBuilder: (event) {
        return event.icon ?? Icon(Icons.help_outline);
      },
      minSelectedDate: DateTime.now().subtract(Duration(days: 360)),
      maxSelectedDate: DateTime.now().add(Duration(days: 360)),
      todayButtonColor: Colors.grey,
      todayBorderColor: Colors.grey,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
    );
  }
}

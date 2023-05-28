import 'package:fitariki/main_providers/calender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/methods.dart';
import '../main_models/weak_model.dart';

class CalenderWidget extends StatefulWidget {
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
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  late WeekdayCount counts;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CalenderProvider>(context, listen: false).getEventsList(startDate: widget.startDate,endDate: widget.endDate,days: widget.days.map((e) => e.id!).toList());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalenderProvider>(builder: (context, provider, _) {
      return Directionality(
          
        textDirection: TextDirection.rtl,
        child: CalendarCarousel<Event>(
          onDayPressed: (date, events) {},
          locale: 'ar',
          weekendTextStyle: const TextStyle(
            color: ColorResources.PRIMARY_COLOR,
          ),
          thisMonthDayBorderColor: Colors.grey,
          // headerText: 'days',
          weekFormat: false,
          markedDatesMap: provider.eventList,
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
            color: Colors.black12,
          ),
          markedDateIconBuilder: (event) {
            return event.icon ?? const Icon(Icons.help_outline);
          },
          minSelectedDate: DateTime.now().subtract(const Duration(days: 360)),
          maxSelectedDate: DateTime.now().add(const Duration(days: 360)),
          todayButtonColor: Colors.grey,
          todayBorderColor: Colors.grey,
          markedDateMoreShowTotal:
              true, // null for not showing hidden events indicator
        ),
      );
    });
  }
}

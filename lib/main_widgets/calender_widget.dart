import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/main_providers/calender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

import '../app/core/utils/color_resources.dart';
import '../data/config/di.dart';
import '../main_models/weak_model.dart';

class CalenderWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool fromAddRequest;
  final List<WeekModel> days;
  const CalenderWidget(
      {Key? key,
      required this.startDate,
      required this.endDate,
        this.fromAddRequest=false,
      required this.days})
      : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  void initState() {
    if(!widget.fromAddRequest) {
      Future.delayed(Duration.zero, () {
        print("ffffffffff${widget.days.map((e) => e.id!).toList()}");
      sl<CalenderProvider>().updateDays(widget.days.map((e) => e.id!).toList());

      sl<CalenderProvider>().getEventsList(startDate: widget.startDate, endDate: widget.endDate,);
    });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalenderProvider>(builder: (context, provider, _) {
      if(provider.isLoad)
        return CircularProgressIndicator();
            else {
        return Directionality(
        textDirection: TextDirection.rtl,
        child: CalendarCarousel<Event>(
          onDayPressed: (date, events) {},
          locale: 'ar',
          headerMargin: EdgeInsets.symmetric(horizontal: 50.w),

          weekendTextStyle: const TextStyle(color: Styles.PRIMARY_COLOR,),

          thisMonthDayBorderColor: Colors.grey.withOpacity(.1),
          // headerText: 'days',
          weekFormat: false,
          markedDatesMap: provider.eventList,
          height: 400.h,
          // selectedDateTime: DateTime(2021,11,11),
          showIconBehindDayText: true,
          markedDateShowIcon: true,
          selectedDayTextStyle: const TextStyle(color: Styles.PRIMARY_COLOR,),
          selectedDayBorderColor: Colors.black12,
          selectedDayButtonColor: Colors.transparent,
          todayTextStyle: const TextStyle(color:  Styles.PRIMARY_COLOR,),
          markedDateIconBuilder: (event) {return event.icon ?? const Icon(Icons.add_alert_rounded);},
          minSelectedDate: DateTime.now().subtract(const Duration(days: 360)),
          maxSelectedDate: DateTime.now().add(const Duration(days: 360)),
          todayButtonColor: Styles.ACCENT_PRIMARY_COLOR,
          todayBorderColor: Colors.grey,
          markedDateMoreShowTotal: true,
        ),
      );
      }
    });
  }
}

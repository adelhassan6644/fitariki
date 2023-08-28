import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/tab_widget.dart';
import '../provider/my_rides_provider.dart';

class MyRidesHeader extends StatelessWidget {
  const MyRidesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRidesProvider>(builder: (context, provider, child) {
      return AnimatedCrossFade(
          crossFadeState: provider.goingDown
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          firstChild: SizedBox(width: context.width),
          secondChild: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Column(
              children: [
                /// Type of Sub trip
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                  child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                          color: Styles.CONTAINER_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        children: List.generate(
                            provider.tabs.length,
                            (index) => Expanded(
                                  child: TabWidget(
                                      title: getTranslated(
                                          provider.tabs[index], context),
                                      isSelected: index == provider.tabIndex,
                                      onTab: () {
                                        if (index != provider.tabIndex) {
                                          provider.onSelectTab(index);
                                          provider.getRides();
                                        }
                                      }),
                                )),
                      )),
                ),

                ///Calender
                Padding(
                  padding: EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_DEFAULT.h),
                  child: TableCalendar(
                      firstDay: provider.kFirstDay,
                      lastDay: provider.kLastDay,
                      headerVisible: false,
                      locale: "ar",
                      focusedDay: provider.focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(provider.selectedDay, day),
                      calendarFormat: provider.calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: const [],
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        cellAlignment: Alignment.center,
                        cellMargin: const EdgeInsets.all(4),
                        rangeEndDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        rangeStartDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        markerDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        cellPadding: const EdgeInsets.all(4),
                        outsideDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        outsideTextStyle: AppTextStyles.w400.copyWith(
                            fontSize: 12, color: Styles.DETAILS_COLOR),
                        todayDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        todayTextStyle: AppTextStyles.w400.copyWith(
                            fontSize: 12, color: Styles.DETAILS_COLOR),
                        selectedDecoration: BoxDecoration(
                            color: Styles.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8)),
                        defaultDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        defaultTextStyle: AppTextStyles.w400.copyWith(
                            fontSize: 12, color: Styles.DETAILS_COLOR),
                        disabledDecoration: BoxDecoration(
                            color: Styles.LIGHT_GREY_BORDER,
                            borderRadius: BorderRadius.circular(8)),
                        disabledTextStyle: AppTextStyles.w400.copyWith(
                            fontSize: 12, color: Styles.DETAILS_COLOR),
                      ),
                      onDaySelected: (v1, v2) => provider.onDaySelected(v1, v2),
                      onFormatChanged: provider.onChangeFormat,
                      onPageChanged: (v) {
                        provider.focusedDay = v;
                      },
                      onCalendarCreated: (v) {
                        Future.delayed(
                            Duration.zero,
                            () => provider.onDaySelected(
                                DateTime.now(), DateTime.now()));
                      }),
                ),
              ],
            ),
          ));
    });
  }
}

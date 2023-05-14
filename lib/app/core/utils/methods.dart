abstract class Methods{
  static diffBtw2Dates({required DateTime startDate,required DateTime endDate, }) {

    var dur = endDate.toLocal().difference(startDate);
    return dur.inDays.toString();

  }
  static WeekdayCount getWeekdayCount(
      {required DateTime startDate, required DateTime endDate, required List<int> weekdays}) {
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
        currentDate = currentDate.add(Duration(days: 7));
      }
    }

    return WeekdayCount(count, days);
  }




}
class WeekdayCount {
  final int count;
  final int days;

  WeekdayCount(this.count, this.days);
  @override
  String toString() {
    // TODO: implement toString
    return "cont: $count -- days:$days  ";
  }
}
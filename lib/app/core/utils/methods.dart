abstract class Methods{
  static diffBtw2Dates({required DateTime startDate,required DateTime endDate, }) {

    var dur = endDate.toLocal().difference(startDate);
    return dur.inDays.toString();

  }
}
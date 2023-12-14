import 'package:flutter/cupertino.dart';
import '../data/config/di.dart';
import '../features/add_request/provider/add_request_provider.dart';
import '../features/post_offer/provider/post_offer_provider.dart';
import '../main_models/weak_model.dart';

class ScheduleProvider extends ChangeNotifier {
  List<WeekModel> selectedDays = [];

  onSelectDay(WeekModel value) {


    if (checkSelectDay(value)) {
      selectedDays.removeAt(
          selectedDays.indexWhere((element) => element.id == value.id));
    } else {
      selectedDays.add(value);
    }
    //for get Days Count
    sl.get<PostOfferProvider>().getDaysCount();
    sl.get<AddRequestProvider>().getDaysCount();
    notifyListeners();
  }

  checkSelectDay(WeekModel value) {
    return selectedDays.indexWhere((element) => element.id == value.id) == -1
        ? false
        : true;
  }
}

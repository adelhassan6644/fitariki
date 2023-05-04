import 'package:flutter/cupertino.dart';
import '../repo/my_trips_repo.dart';

class MyTripsProvider extends ChangeNotifier {
  MyTripsRepo myTripsRepo;
  MyTripsProvider({required this.myTripsRepo});


  List<String> taps = ["previous","current", "waiting",];
  int currentTap = 0;


  onSelectTap(index) {
    currentTap = index;
    notifyListeners();
  }

}

import 'package:flutter/cupertino.dart';

import '../repo/add_offer_repo.dart';

class AddOfferProvider extends ChangeNotifier{
  AddOfferRepo addOfferRepo;
  AddOfferProvider({required this.addOfferRepo});

  DateTime startDate =DateTime.now();
  onSelectStartDate(v){
    startDate = v;
    notifyListeners();
  }

  DateTime endDate =DateTime.now();
  onSelectEndDate(v){
    endDate = v;
    notifyListeners();
  }

  bool addFollowers = true;
  onChange(v){
    addFollowers=v;
    notifyListeners();
  }

}
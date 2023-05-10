import 'package:flutter/cupertino.dart';

import '../repo/add_offer_repo.dart';


class AddOfferProvider extends ChangeNotifier{
  AddOfferRepo addOfferRepo;
  AddOfferProvider({required this.addOfferRepo});


  String? minPrice,note;

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

  List<String> followers = ["محمد احمد","لؤي احمد","محمد الفيصل"];
  List<String> selectedFollowers = ["محمد احمد","لؤي احمد","محمد الفيصل"];
  onSelectFollow(v,index){
    if(v){
      selectedFollowers.add(followers[index]);
    }else{
      selectedFollowers.removeAt(index);
    }
    notifyListeners();
  }

}
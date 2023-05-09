import 'package:fitariki/features/replay_offer/repo/replay_offer_repo.dart';
import 'package:flutter/cupertino.dart';


class ReplayOfferProvider extends ChangeNotifier{
  ReplayOfferRepo replayOfferRepo;
  ReplayOfferProvider({required this.replayOfferRepo});

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
import 'package:flutter/cupertino.dart';

class FollowersProvider extends ChangeNotifier {
  bool addFollowers = true;
  onChange(v) {
    addFollowers = v;
    notifyListeners();
  }

  List<String> followers = ["محمد احمد", "لؤي احمد", "محمد الفيصل"];
  List<String> selectedFollowers = [];
  onSelectFollow(v, index) {
    if (v) {
      selectedFollowers.add(followers[index]);
    } else {
      selectedFollowers.remove(followers[index]);
    }
    notifyListeners();
  }
}

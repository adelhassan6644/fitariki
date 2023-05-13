import 'package:flutter/material.dart';
import '../repo/wishlist_repo.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistRepo wishlistRepo;

  WishlistProvider({
    required this.wishlistRepo,
  });

  List<String> tabs = ["delivery_offers", "captains"];
  int currentTab = 0;
  selectedTab(int value) {
    currentTab = value;
    notifyListeners();
  }
}

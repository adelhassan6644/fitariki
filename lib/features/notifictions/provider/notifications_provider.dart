import 'package:flutter/material.dart';
import '../repo/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsRepo notificationsRepo;

  NotificationsProvider({
    required this.notificationsRepo,
  });

  List<String> tabs = ["delivery_offers", "delivery_requests"];

  int currentTab = 0;
  selectedTab(int value) {
    currentTab = value;
    notifyListeners();
  }
}

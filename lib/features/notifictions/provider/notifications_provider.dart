import 'package:flutter/material.dart';
import '../repo/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsRepo notificationsRepo;

  NotificationsProvider({
    required this.notificationsRepo,
  });
}

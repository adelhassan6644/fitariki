part of notification_helper;

scheduleNotification(String title, String subtitle, String data) async {
  var rng = math.Random();
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_id',
    'your channel name',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
    icon: '@mipmap/ic_launcher',
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await _notificationsPlugin!.show(
    rng.nextInt(100000),
    title,
    subtitle,
    platformChannelSpecifics,
    payload: data,
  );
}

void iOSPermission() {
  _firebaseMessaging!.requestPermission(
      alert: true, announcement: true, badge: true, sound: true);
}

void handlePath(Map dataMap) {
  updateUserFunctions(notify: dataMap);
  handlePathByRoute(dataMap);
}

updateUserFunctions({@required notify}) async {
  Future.delayed(Duration.zero, () {
    sl<HomeProvider>().getOffers();
    sl<HomeProvider>().getUsers();
    if (sl<ProfileProvider>().isLogin) {
      sl<NotificationsProvider>().getNotifications();
      sl<HomeProvider>().checkRunningTrips();
      sl<MyTripsProvider>().getCurrentTrips();
      sl<MyTripsProvider>().getPreviousTrips();
      sl<MyTripsProvider>().getPendingTrips();
    }
  });
}

Future<void> handlePathByRoute(Map notify) async {
  CustomNavigator.push(Routes.NOTIFICATIONS);
}

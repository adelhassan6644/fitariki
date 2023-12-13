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
  log("startHandlePathByRoute ${notify}");
  notify as Map<String, dynamic>;

  PayloadData data =
      PayloadData.fromJson(json.decode(notify["data"]) as Map<String, dynamic>);


  if (data.url != null) {
    if (data.url == "TRACKING") {
      CustomNavigator.push(
        Routes.TRACKING,
        arguments: data.myRideModel,
      );
    }
    if (data.url == Routes.PAYMENT) {
      CustomNavigator.push(Routes.PAYMENT, arguments: {
        'isFromMyTrips':true
      }
      );
    }
    CustomNavigator.push(
      data.url!,
      arguments: data.id,
    );
  } else {
    CustomNavigator.push(Routes.NOTIFICATIONS);
  }
}

class PayloadData {
  int? id;
  String? url;
  int? status;
  MyRideModel? myRideModel;

  PayloadData({
    required this.id,
    required this.url,
    required this.status,
    this.myRideModel,
  });

  factory PayloadData.fromJson(Map<String, dynamic> json) => PayloadData(
      id: json["id"],
      url: json["url"],
      status: json["status"],
      myRideModel:
          json["ride_data"] != null ? MyRideModel.fromJson(json["ride_data"]) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "status": status,
      };
}

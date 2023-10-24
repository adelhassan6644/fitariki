part of notification_helper;

FlutterLocalNotificationsPlugin? _notificationsPlugin =
    FlutterLocalNotificationsPlugin();

localNotification() {
  _notificationsPlugin = FlutterLocalNotificationsPlugin();
  if (Platform.isIOS) {
    _notificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var ios = const DarwinInitializationSettings(
    defaultPresentBadge: true,
    defaultPresentAlert: true,
    defaultPresentSound: true,
  );
  var initSetting = InitializationSettings(
    android: android,
    iOS: ios,
  );
  _notificationsPlugin!.initialize(
    initSetting,
    onDidReceiveNotificationResponse: (not) {
      log("onSelect Message ${not.payload}");
      handlePath(json.decode(not.payload ?? ""));
    },
  );
}

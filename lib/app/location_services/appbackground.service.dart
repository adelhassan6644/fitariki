import 'dart:io';
import 'package:flutter_background/flutter_background.dart';

import '../../features/tracking/repo/tracking_repo.dart';
import 'app_permission_handler.service.dart';



class AppbackgroundService {
  //

  startBg() async {
    final permitted =
        await AppPermissionHandlerService().handleLocationRequest();
    if (!permitted) {
      return;
    }
    // await TrackingRepo().prepareLocationListener();
    // await OrderManagerService().startListener();
    // BackgroundOrderService();
    // TaxiBackgroundOrderService();

    //
    if (Platform.isAndroid) {
      //
      const androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: "Background service",
        notificationText: "Background notification to keep app running",
        notificationImportance: AndroidNotificationImportance.Default,
        notificationIcon: AndroidResource(
          name: 'notification_icon',
          defType: 'drawable',
        ), // Default is ic_launcher from folder mipmap
      );

      //check for permission
      //CALL THE PERMISSION HANDLER
      final allowed =
          await AppPermissionHandlerService().handleBackgroundRequest();
      //
      if (allowed) {
        await FlutterBackground.initialize(androidConfig: androidConfig);
        await FlutterBackground.enableBackgroundExecution();
      }
    }
  }

  void stopBg() {
    // Platform.isAndroid
    if (Platform.isAndroid) {
      bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
      if (enabled) {
        FlutterBackground.disableBackgroundExecution();
      }
    }
    // OrderManagerService().stopListener();
  }
}

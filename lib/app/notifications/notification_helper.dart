library notification_helper;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../data/config/di.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/my_rides/model/my_rides_model.dart';
import '../../features/my_trips/provider/my_trips_provider.dart';
import '../../features/notifications/model/notifications_model.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
part 'firebase_notification_helper.dart';
part 'notification_operation.dart';
part 'local_notification.dart';

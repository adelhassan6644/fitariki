import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/dio/dio_client.dart';

class NotificationsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  NotificationsRepo({required this.dioClient, required this.sharedPreferences});

}

import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/dio/dio_client.dart';

class TrackingRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  TrackingRepo({required this.dioClient, required this.sharedPreferences});
  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitariki/app/core/utils/app_storage_keys.dart';

 class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences});

 bool notFirstTime(){
    return sharedPreferences.containsKey(AppStorageKey.isFirstTime);
  }

  setFirstTime(){
  sharedPreferences.setBool(AppStorageKey.isFirstTime, true);
  }



}
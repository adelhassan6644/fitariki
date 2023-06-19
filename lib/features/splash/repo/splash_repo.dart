import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitariki/app/core/utils/app_storage_keys.dart';

 class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences});

 bool isFirstTime(){
    return !sharedPreferences.containsKey(AppStorageKey.notFirstTime);
  }

  bool isCompleteProfile(){
    return sharedPreferences.containsKey(AppStorageKey.isCompleteProfile);
  }

  bool isLogin(){
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setFirstTime(){
  sharedPreferences.setBool(AppStorageKey.notFirstTime, true);
  }



}
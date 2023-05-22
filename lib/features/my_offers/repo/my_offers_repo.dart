import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/dio/dio_client.dart';

class MyOffersRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyOffersRepo({required this.dioClient,required this.sharedPreferences});
}
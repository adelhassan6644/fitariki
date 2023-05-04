import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/dio/dio_client.dart';

class MyTripsRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyTripsRepo({required this.dioClient,required this.sharedPreferences});
}
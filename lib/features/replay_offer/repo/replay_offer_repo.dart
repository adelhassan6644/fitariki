import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/dio/dio_client.dart';

class ReplayOfferRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ReplayOfferRepo({required this.dioClient,required this.sharedPreferences});
}
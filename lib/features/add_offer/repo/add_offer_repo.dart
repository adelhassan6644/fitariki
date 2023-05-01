import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/dio/dio_client.dart';

class AddOfferRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddOfferRepo({required this.dioClient,required this.sharedPreferences});
}
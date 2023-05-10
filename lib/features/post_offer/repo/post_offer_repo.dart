import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/dio/dio_client.dart';

class PostOfferRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  PostOfferRepo({required this.dioClient,required this.sharedPreferences});
}
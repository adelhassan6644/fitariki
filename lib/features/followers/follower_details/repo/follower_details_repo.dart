
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/dio/dio_client.dart';

class FollowerDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FollowerDetailsRepo(
      {required this.dioClient, required this.sharedPreferences});
}

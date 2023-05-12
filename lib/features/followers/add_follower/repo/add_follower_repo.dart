
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/dio/dio_client.dart';

class AddFollowersRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddFollowersRepo(
      {required this.dioClient, required this.sharedPreferences});
}

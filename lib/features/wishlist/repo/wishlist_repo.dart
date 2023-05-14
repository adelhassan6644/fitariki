import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/dio/dio_client.dart';

class WishlistRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  WishlistRepo({required this.dioClient, required this.sharedPreferences});

}

import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/dio/dio_client.dart';

class TripDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  TripDetailsRepo({required this.dioClient, required this.sharedPreferences});

  getWishlist() {}
}

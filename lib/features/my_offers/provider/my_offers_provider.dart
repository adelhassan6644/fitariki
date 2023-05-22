import 'package:flutter/cupertino.dart';
import '../repo/my_offers_repo.dart';

class MyOffersProvider extends ChangeNotifier {
  MyOffersRepo myOffersRepo;
  MyOffersProvider({required this.myOffersRepo});
}

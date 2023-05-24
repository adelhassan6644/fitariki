import 'package:flutter/material.dart';
import '../repo/trip_details_repo.dart';

class TripDetailsProvider extends ChangeNotifier {
  final TripDetailsRepo tripDetailsRepo;

  TripDetailsProvider({
    required this.tripDetailsRepo,
  });

  TextEditingController negotiationPrice = TextEditingController(text: "");
}

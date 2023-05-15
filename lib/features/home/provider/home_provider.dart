import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/error/failures.dart';
import '../repo/home_repo.dart';


class HomeProvider extends ChangeNotifier{
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  bool isLoading = false;
  List<OfferModel>? offer;
  getOffers() async {
    offer=[];
    isLoading = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
    await homeRepo.getOffer();
    response.fold((l) => null, (response) {
      offer=   List<OfferModel>.from(response.data["data"]["offers"]!.map((x) => OfferModel.fromJson(x)));
      isLoading = false;
      notifyListeners();
    });
  }
}
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../model/favourite_model.dart';
import '../repo/wishlist_repo.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistRepo wishlistRepo;

  WishlistProvider({
    required this.wishlistRepo,
  });

  List<String> driverTabs = ["delivery_offers", "passengers"];

  List<String> clientTabs = ["delivery_offers", "captains"];

  int currentTab = 0;
  selectedTab(int value) {
    currentTab = value;
    notifyListeners();
  }

  bool isLoading = false;
  FavouriteModel? favouriteModel;
  getWishList() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await wishlistRepo.getWishList();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        favouriteModel = FavouriteModel.fromJson(response.data['data']);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  postWishList({int? offerId, int? userId}) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await wishlistRepo.postWishList(offerId: offerId, userId: userId);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        getWishList();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}

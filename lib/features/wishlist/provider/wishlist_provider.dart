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
  }) {
    wishListOfferId.clear();
    if (isLogin) {
      getWishList();
    }
  }

  bool get isLogin => wishlistRepo.isLoggedIn();

  List<int> wishListOfferId = [];
  List<int> wishListUsersId = [];
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
    // try {
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
        wishListOfferId = [];
        if (favouriteModel!.offers != null &&
            favouriteModel!.offers!.isNotEmpty) {
          for (var e in favouriteModel!.offers!) {
            wishListOfferId.add(e.id!);
          }
        }
        wishListUsersId = [];
        if (favouriteModel!.drivers != null &&
            favouriteModel!.drivers!.isNotEmpty) {
          for (var e in favouriteModel!.drivers!) {
            wishListUsersId.add(e.id!);
          }
        }
        if (favouriteModel!.clients != null &&
            favouriteModel!.clients!.isNotEmpty) {
          for (var e in favouriteModel!.clients!) {
            wishListUsersId.add(e.id!);
          }
        }
        isLoading = false;
        notifyListeners();
      });
    // }
    // catch (e) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   isLoading = false;
    //   notifyListeners();
    // }
  }

  postWishList(
      {required int id, required bool isOffer, bool isExist = false}) async {
    // try {
      if (isExist) {
        if (isOffer) {
          wishListOfferId.remove(id);
        } else {
          wishListUsersId.remove(id);
        }
      } else {
        if (isOffer) {
          wishListOfferId.add(id);
        } else {
          wishListUsersId.add(id);
        }
      }
      notifyListeners();

      Either<ServerFailure, Response> response =
          await wishlistRepo.postWishList(id: id, isOffer: isOffer);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        if (isExist) {
          showToast(
            "تم الازلة من المحفوظات بنجاح",
            backGroundColor: ColorResources.ACTIVE,
          );
          // CustomSnackBar.showSnackBar(
          //     notification: AppNotification(
          //         message: "تم الازلة من المحفوظات بنجاح",
          //         isFloating: true,
          //         backgroundColor: ColorResources.ACTIVE,
          //         borderColor: Colors.transparent));
        } else {
          showToast(
            "تم الاضافة الي المحفوظات بنجاح",
            backGroundColor: ColorResources.ACTIVE,
          );

          // CustomSnackBar.showSnackBar(
          //     notification: AppNotification(
          //         message: "تم الاضافة الي المفضلة بنجاح",
          //         isFloating: true,
          //         backgroundColor: ColorResources.ACTIVE,
          //         borderColor: Colors.transparent));
        }
      });
      getWishList();
      notifyListeners();
    // } catch (e) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   notifyListeners();
    // }
  }
}

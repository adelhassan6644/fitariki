import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../provider/wishlist_provider.dart';

class SaveButton extends StatelessWidget {
  final int? id;
  final bool isOffer;

  const SaveButton({super.key, required this.id, required this.isOffer});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (_, wishlistProvider, child) {
        bool isUserExist = false;
        bool isOfferExist = false;
        isUserExist =
            wishlistProvider.wishListUsersId.indexWhere((e) => e == id) != -1;
        isOfferExist =
            wishlistProvider.wishListOfferId.indexWhere((e) => e == id) != -1;
        return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            radius: 50,
            onTap: () {
              if (wishlistProvider.isLogin) {
                sl<WishlistProvider>().postWishList(
                    id: id!,
                    isOffer: isOffer,
                    isExist: isOffer ? isOfferExist : isUserExist);
              } else {
                showToast("برجاء التسجيل اولا !");
              }
            },
            child: customImageIconSVG(
                imageName: isOffer ? isOfferExist ? SvgImages.saved : SvgImages.bookMark: isUserExist? SvgImages.saved : SvgImages.bookMark,
                color: Colors.black,
                width: 18));
      },
    );
  }
}

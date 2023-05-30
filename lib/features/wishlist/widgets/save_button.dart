import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../provider/wishlist_provider.dart';

class SaveButton extends StatelessWidget {
  final int id;

  const SaveButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (_, wishlistProvider, child) {
        bool isExist =false;
        isExist = wishlistProvider.wishIdList.indexWhere((e) => e == id) != -1;
        return InkWell(
          splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            radius: 50,
            onTap: () {
              if (wishlistProvider.isLogin) {
                sl<WishlistProvider>().postWishList(offerId: id,isExist: isExist);
              }
              else {
                showToast("برجاء التسجيل اولا !");
              }
            },
            child: customImageIconSVG(
                imageName: isExist ? SvgImages.saved : SvgImages.bookMark,
                color: Colors.black,
                width: 18));
      },
    );
  }
}

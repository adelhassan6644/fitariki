import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/auth/provider/firebase_auth_provider.dart';
import 'package:fitariki/features/followers/followers/provider/followers_provider.dart';
import 'package:fitariki/features/wishlist/provider/wishlist_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../profile/provider/profile_provider.dart';
import 'more_button.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: ColorResources.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ]),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Consumer<ProfileProvider>(
          builder: (_, provider, child) {
            return Column(
              children: [
                MoreButton(
                  title: getTranslated("personal_information", context),
                  icon: SvgImages.file,
                  onTap: () => CustomNavigator.push(Routes.EDIT_PROFILE,
                      arguments: false),
                ),
                if (provider.role != "driver")
                  MoreButton(
                    title: getTranslated("followers", context),
                    icon: SvgImages.addFollower,
                    onTap: () {
                      Provider.of<FollowersProvider>(context,listen: false).getFollowers();
                      CustomNavigator.push(Routes.FOLLOWERS);
                    },
                  ),
                MoreButton(
                  title: getTranslated("archives", context),
                  icon: SvgImages.bookMark,
                  onTap: () {
                 // CustomNavigator.push(Routes.USER_PROFILE);
                    sl<WishlistProvider>().getWishList();
                    CustomNavigator.push(Routes.WISHLIST);
                  },
                ),
                MoreButton(
                  title: getTranslated("notifications", context),
                  icon: SvgImages.notifications,
                  onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS),
                ),
                MoreButton(
                  title: getTranslated("bank_data", context),
                  icon: SvgImages.card,
                ),
                MoreButton(
                  title: provider.isDriver
                      ? getTranslated("clients_evaluation", context)
                      : getTranslated("captain_evaluation", context),
                  icon: SvgImages.rate,
                  onTap: () => CustomNavigator.push(
                    Routes.RATTING,
                    arguments: provider.isDriver
                        ? getTranslated("clients_evaluation", context)
                        : getTranslated("captain_evaluation", context),
                  ),
                ),
                MoreButton(
                  title: getTranslated("contact_with_us", context),
                  icon: SvgImages.call,
                  onTap: ()=>CustomNavigator.push(Routes.CONTACT_WITH_US),
                ),
                Consumer<FirebaseAuthProvider>(
                  builder: (_, authProvider, child) {
                    return MoreButton(
                      title: getTranslated("log_out", context),
                      icon: SvgImages.logout,
                      withBorder: false,
                      isLogout: true,
                      onTap: authProvider.logOut,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

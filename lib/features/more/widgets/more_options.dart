import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/followers/followers/provider/followers_provider.dart';
import 'package:fitariki/features/transactions/provider/transactions_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../auth/provider/auth_provider.dart';
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
            color: Styles.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ]),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            MoreButton(
              title: getTranslated("personal_information", context),
              icon: SvgImages.file,
              onTap: () {
                sl<ProfileProvider>().getProfile();
                CustomNavigator.push(Routes.EDIT_PROFILE, arguments: false);
              },
            ),
            Visibility(
              visible: !sl<ProfileProvider>().isDriver,
              child: MoreButton(
                title: getTranslated("followers", context),
                icon: SvgImages.addFollower,
                onTap: () {
                  sl<FollowersProvider>().getFollowers();
                  CustomNavigator.push(Routes.FOLLOWERS);
                },
              ),
            ),

            MoreButton(
              title: getTranslated("archives", context),
              icon: SvgImages.bookMark,
              onTap: () => CustomNavigator.push(Routes.WISHLIST),
            ),

            ///Notifications
            MoreButton(
              title: getTranslated("notifications", context),
              icon: SvgImages.notifications,
              onTap: () {
                CustomNavigator.push(Routes.NOTIFICATIONS);
              },
            ),
            // MoreButton(
            //   title: getTranslated("bank_data", context),
            //   icon: SvgImages.card,
            // ),
            // MoreButton(
            //   title: sl<ProfileProvider>().isDriver
            //       ? getTranslated("clients_evaluation", context)
            //       : getTranslated("captain_evaluation", context),
            //   icon: SvgImages.rate,
            //   onTap: () {
            //     Provider.of<SendFeedbackProvider>(context,listen: false).getFeedback();
            //         CustomNavigator.push(Routes.FEEDBACK,);
            //     // CustomNavigator.push(Routes.RATE_USER,arguments: 20);
            //   },
            // ),

            ///Change Password
            MoreButton(
              title: getTranslated("change_password", context),
              icon: SvgImages.lockIcon,
              onTap: () => CustomNavigator.push(Routes.CHANGE_PASSWORD),
            ),

            ///Transactions
            Consumer<ProfileProvider>(builder: (_, provider, child) {
              return Visibility(
                visible: !provider.isDriver,
                child: MoreButton(
                  title: getTranslated("transactions", context),
                  icon: SvgImages.card,
                  onTap: () {
                    sl<TransactionsProvider>().getTransactions();
                    CustomNavigator.push(Routes.TRANSACTIONS);
                  },
                ),
              );
            }),

            ///Wallet
            Consumer<ProfileProvider>(builder: (_, provider, child) {
              return Visibility(
                visible: !provider.isDriver,
                child: MoreButton(
                  title: getTranslated("wallet", context),
                  icon: SvgImages.wallet,
                  leading: Text(
                      "${provider.profileModel?.client?.wallet?.toString() ?? 0.0}  ${getTranslated("sar", context)}",
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 14, color: Styles.DISABLED)),
                ),
              );
            }),

            ///Contact With Us
            MoreButton(
              title: getTranslated("contact_with_us", context),
              icon: SvgImages.call,
              onTap: () => CustomNavigator.push(Routes.CONTACT_WITH_US),
            ),

            MoreButton(
              title: getTranslated("log_out", context),
              icon: SvgImages.logout,
              withBorder: false,
              isLogout: true,
              onTap: sl<AuthProvider>().logOut,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../../auth/provider/firebase_auth_provider.dart';
import '../../guest/guest_mode.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';
import '../widgets/wallet_card.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAuthProvider>(
      builder: (context, provider, child) {
        return provider.isLogin
            ? ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  const ProfileCard(),
                  Consumer<ProfileProvider>(
                    builder: (_, provider, child) {
                      return provider.role == "driver"
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 24.h,
                                ),
                                const WalletCard(),
                              ],
                            )
                          : const SizedBox();
                    },
                  ),
                  const MoreOptions(),
                ],
              )
            : Column(
                children: [
                  CustomAppBar(
                    title: getTranslated("profile", context),
                    withBorder: true,
                    withBack: false,
                  ),
                  const Expanded(child: GuestMode()),
                ],
              );
      },
    );
  }
}

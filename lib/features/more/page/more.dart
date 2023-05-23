import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../guest/guest_mode.dart';
import '../../profile/provider/profile_provider.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';
import '../widgets/wallet_card.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return provider.isLogin
            ? Column(
                children: [
                  Expanded(
                    child: ListAnimator(
                      customPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      data: [
                        const ProfileCard(),
                        if (provider.isDriver)
                          Column(
                            children: [
                              SizedBox(
                                height: 24.h,
                              ),
                              WalletCard(availableBalance: provider.wallet),
                            ],
                          ),
                        const MoreOptions(),
                      ],
                    ),
                  ),
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

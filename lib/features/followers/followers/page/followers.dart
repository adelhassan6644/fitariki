import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/followers/add_follower/page/add_follower.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_show_model_bottom_sheet.dart';
import '../../../../navigation/routes.dart';
import '../../add_follower/provider/add_follower_provider.dart';
import '../widgets/follower_button.dart';

class Followers extends StatelessWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            withBorder: true,
            title: getTranslated("followers", context),
            withBack: true,
            actionWidth: 40,
            actionChild: GestureDetector(
              onTap: () => customShowModelBottomSheet(
                onClose:
                    Provider.of<AddFollowerProvider>(context, listen: false)
                        .reset,
                body: const AddFollower(),
              ),
              child: SizedBox(
                width: 40,
                child: Text(
                  getTranslated("add", context),
                  textAlign: TextAlign.start,
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 14, color: ColorResources.SYSTEM_COLOR),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            physics: const BouncingScrollPhysics(),
            children: [
              FollowerButton(
                title: "يارا محمد",
                onTap: () => CustomNavigator.push(Routes.FOLLOWER_DETAILS,
                    arguments: "يارا محمد"),
              ),
              FollowerButton(
                title: "خالد محمد",
                onTap: () => CustomNavigator.push(Routes.FOLLOWER_DETAILS,
                    arguments: "يارا محمد"),
              )
            ],
          ))
        ],
      ),
    );
  }
}

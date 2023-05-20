import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/animated_widget.dart';
import 'package:fitariki/features/followers/add_follower/page/add_follower.dart';
import 'package:fitariki/features/followers/followers/widgets/follower_button_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_show_model_bottom_sheet.dart';
import '../../../../components/empty_widget.dart';
import '../../add_follower/provider/add_follower_provider.dart';
import '../provider/followers_provider.dart';
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
              child: Consumer<FollowersProvider>(builder: (_, provider, child) {
            return ListAnimator(
              customPadding: EdgeInsets.symmetric(vertical: 8.h),
              data: provider.isLoading
                  ? List.generate(5, (index) => const FollowerButtonShimmer())
                  : provider.model?.data == null ||
                          provider.model!.data!.isEmpty
                      ? [const EmptyState(txt: "لا يوحد تابعيين",)]
                      : List.generate(
                          provider.model!.data!.length,
                          (index) => FollowerButton(
                                followerModel: provider.model!.data![index],
                              )),
            );
          }))
        ],
      ),
    );
  }
}

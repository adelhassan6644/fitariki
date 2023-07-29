import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/followers/follower_details/model/follower_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/utils/text_styles.dart';
import '../../../../navigation/routes.dart';

class FollowerButton extends StatelessWidget {
  const FollowerButton({required this.followerModel, Key? key})
      : super(key: key);
  final FollowerModel followerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Styles.HINT_COLOR, width: 0.5))),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: InkWell(
        onTap: () => CustomNavigator.push(Routes.FOLLOWER_DETAILS,
            arguments: followerModel),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(followerModel.name??"",
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                            color: Styles.SECOUND_PRIMARY_COLOR)),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Styles.DISABLED,
                    size: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

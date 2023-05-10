import 'package:fitariki/main_providers/followers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/chekbox_listtile.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowersProvider>(
      builder: (_, provider, child) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  getTranslated("followers", context),
                  style: AppTextStyles.w600.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                  activeColor: ColorResources.GREEN,
                  value: provider.addFollowers,
                  onChanged: provider.onChange,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Visibility(
              visible: provider.addFollowers,
              child: Column(
                children: [
                  ...List.generate(
                    provider.followers.length,
                    (index) => CheckBoxListTile(
                      title: provider.followers[index],
                      onChange: (v) {
                        provider.onSelectFollow(v, index);
                      },
                      check: provider.selectedFollowers
                          .contains(provider.followers[index]),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: ColorResources.WHITE_COLOR,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 2.0,
                              spreadRadius: 0,
                              offset: const Offset(0, 4))
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            getTranslated("add_follower", context),
                            style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        GestureDetector(
                            child: const Icon(
                          Icons.add,
                          size: 18,
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        );
      },
    );
  }
}

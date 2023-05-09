import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/chekbox_listtile.dart';
import '../provider/replay_offer_provider.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({required this.provider, Key? key}) : super(key: key);
  final ReplayOfferProvider provider;

  @override
  Widget build(BuildContext context) {
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
                  check:provider.selectedFollowers.contains(provider.followers[index]) ,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    color: ColorResources.WHITE_COLOR,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 5.0,
                          spreadRadius: -1,
                          offset: const Offset(0, 6))
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
      ],
    );
  }
}

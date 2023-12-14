import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../components/checkbox_list_tile.dart';
import '../features/followers/followers/provider/followers_provider.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class FollowersWidget extends StatefulWidget {
  const FollowersWidget({Key? key}) : super(key: key);

  @override
  State<FollowersWidget> createState() => _FollowersWidgetState();
}

class _FollowersWidgetState extends State<FollowersWidget> {
  @override
  void initState() {
   Future.delayed(Duration.zero,(){
     Provider.of<FollowersProvider>(context,listen: false).getFollowers();
   });
    super.initState();
  }
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
                  activeColor: Styles.GREEN,
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
                    provider.model?.data?.length ?? 0,
                    (index) => CheckBoxListTile(
                      title: provider.model?.data?[index].name ?? "",
                      onChange: (v) {
                        provider.onSelectFollow(v, index);
                      },
                      check: provider.selectedFollowers
                          .contains(provider.model?.data?[index]),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: ()=>CustomNavigator.push(Routes.FOLLOWERS),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Styles.WHITE_COLOR,
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

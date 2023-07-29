import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/tab_widget.dart';
import '../provider/home_provider.dart';

class RoleTypeWidget extends StatelessWidget {
  const RoleTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return provider.isLogin
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.PADDING_SIZE_DEFAULT,
                    0,
                    Dimensions.PADDING_SIZE_DEFAULT,
                    14),
                child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Styles.CONTAINER_BACKGROUND_COLOR,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: List.generate(
                          provider.titles.length,
                          (index) => Expanded(
                                child: TabWidget(
                                    title: getTranslated(
                                        provider.titles[index], context),
                                    isSelected: index == provider.roleIndex,
                                    onTab: () => provider.onSelectRole(index)),
                              )),
                    )),
              );
      },
    );
  }
}

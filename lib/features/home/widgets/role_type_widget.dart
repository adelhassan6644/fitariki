import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/tab_widget.dart';
import '../provider/home_provider.dart';
import 'filter_Bottom_sheet.dart';

class RoleTypeWidget extends StatelessWidget {
  const RoleTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Visibility(
          visible: !provider.isLogin,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,
                0, Dimensions.PADDING_SIZE_DEFAULT, 14),
            child: Row(
              children: [
                Expanded(
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
                                      onTab: () =>
                                          provider.onSelectRole(index)),
                                )),
                      )),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () => customShowModelBottomSheet(
                    body: const FilterBottomSheet(),
                    // onClose: () =>
                    //     Provider.of<HomeProvider>(context, listen: false)
                    //         .reset(),
                  ),
                  child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                          color: Styles.CONTAINER_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: customImageIconSVG(
                        imageName: SvgImages.filter,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

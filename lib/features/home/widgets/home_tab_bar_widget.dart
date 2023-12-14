import 'package:flutter/cupertino.dart';
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

class HomeTabBarWidget extends StatelessWidget {
  const HomeTabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.isLogin,
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
                        children: [
                          Expanded(
                            child: TabWidget(
                                title:
                      provider.isDriver?getTranslated("delivery_requests", context):   getTranslated("delivery_offers", context),
                                isSelected: provider.tab == 0,
                                onTab: () => provider.onSelectTab(0)),
                          ),
                          Expanded(
                            child: TabWidget(
                                title: getTranslated(
                                    provider.isDriver
                                        ? "passengers"
                                        : "captains",
                                    context),
                                isSelected: 1 == provider.tab,
                                onTab: () => provider.onSelectTab(1)),
                          )
                        ],
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
                    // onClose: !provider.isLoading ? provider.reset : null,
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

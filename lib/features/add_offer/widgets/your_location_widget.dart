import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/expansion_tile_widget.dart';
import '../../../main_widgets/marquee_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/add_offer_provider.dart';

class YourLocationWidget extends StatelessWidget {
  const YourLocationWidget({required this.provider, Key? key})
      : super(key: key);
  final AddOfferProvider provider;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("your_residence_housing_location", context),
      children: [
        GestureDetector(
          onTap: () {
            CustomNavigator.push(Routes.Pick_Location,
                arguments: provider.onSelectStartLocation);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ColorResources.LIGHT_BORDER_COLOR, width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: MarqueeWidget(
                    child: Text(
                      provider.startLocation?.address ??
                          getTranslated(
                              "select_your_residence_housing_location",
                              context),
                      style: AppTextStyles.w400.copyWith(
                          color: provider.startLocation?.address == null
                              ? ColorResources.DISABLED
                              : ColorResources.SECOUND_PRIMARY_COLOR,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                customImageIconSVG(imageName: SvgImages.map)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

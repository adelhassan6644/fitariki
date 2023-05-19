import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

import '../../../components/custom_images.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/marquee_widget.dart';
import '../../../main_models/base_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/post_offer_provider.dart';

class YourLocationWidget extends StatelessWidget {
  const YourLocationWidget({required this.provider, Key? key})
      : super(key: key);
  final PostOfferProvider provider;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("your_residence_housing_location", context),
      childrenPadding: 4,
      children: [
        GestureDetector(
          onTap: () {
            CustomNavigator.push(Routes.PICK_LOCATION,
                arguments:  BaseModel(valueChanged: provider.onSelectStartLocation,object: provider.startLocation));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: ColorResources.WHITE_COLOR,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0,
                    spreadRadius: -1,
                    offset: const Offset(0, 2))
              ],
            ),
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

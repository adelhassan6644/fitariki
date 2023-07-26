import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/checkbox_list_tile.dart';
import '../../../components/custom_address_picker.dart';
import '../../../components/expansion_tile_widget.dart';
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
        CustomAddressPicker(
          hint:
              getTranslated("select_your_residence_housing_location", context),
          onPicked: provider.onSelectStartLocation,
          location: provider.startLocation,
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
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 12.h,
          ),
          child: CheckBoxListTile(
            title: getTranslated("my_residence_housing_location", context),
            onChange: provider.onSelect,
            check: provider.sameHomeLocation,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/tab_widget.dart';
import '../provider/my_trips_provider.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({required this.provider, Key? key}) : super(key: key);

final  MyTripsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: 8),
      child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color:ColorResources.CONTAINER_BACKGROUND_COLOR,
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: List.generate(
                provider.taps.length,
                    (index) => Expanded(
                  child: TabWidget(
                      title: getTranslated( provider.taps[index], context),
                      isSelected: index ==  provider.currentTap,
                      onTab: () => provider.onSelectTap(index)),
                )),
          )),
    );
  }
}

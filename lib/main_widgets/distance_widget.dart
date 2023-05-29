import 'package:flutter/cupertino.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/dimensions.dart';
import '../app/core/utils/methods.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_images.dart';

class DistanceWidget extends StatelessWidget {
  const DistanceWidget(
      {required this.isCaptain,
      required this.lat1,
      required this.long1,
      required this.lat2,
      required this.long2,
      Key? key})
      : super(key: key);
  final bool isCaptain;
  final String lat1, long1, lat2, long2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
            imageName: SvgImages.sparkles,
            color: ColorResources.PRIMARY_COLOR,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            isCaptain
                ? getTranslated(
                    "the_client_starting_point_is_further_away_from_you",
                    context)
                : getTranslated(
                    "the_captain_starting_point_is_further_away_from_you",
                    context),
            maxLines: 1,
            style: AppTextStyles.w400.copyWith(
                fontSize: 10,
                color: ColorResources.HINT_COLOR,
                overflow: TextOverflow.ellipsis),
          ),
          Text(
            Methods.calcDistance(
                    lat1: lat1, long1: long1, lat2: lat2, long2: long2)
                .toString(),
            maxLines: 1,
            style: AppTextStyles.w600.copyWith(
                fontSize: 10,
                color: ColorResources.PRIMARY_COLOR,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

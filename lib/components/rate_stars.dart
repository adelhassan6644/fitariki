import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/text_styles.dart';
import 'custom_images.dart';

class RateStars extends StatelessWidget {
  const RateStars({Key? key, this.rate, this.size, this.showRateNumber = true})
      : super(key: key);

  final num? rate;
  final double? size;
  final bool showRateNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            ...List.generate(
              rate?.toInt() ?? 0,
              (index) => customImageIconSVG(
                  imageName: SvgImages.fillStar, width: size, height: size),
            ),
            ...List.generate(
              5 - (rate?.toInt() ?? 0),
              (index) => customImageIconSVG(
                  imageName: SvgImages.emptyStar, width: size, height: size),
            )
          ],
        ),
        if (showRateNumber)
          Text("(${rate?.toInt().toDouble()??0.0})",
              style: AppTextStyles.w400
                  .copyWith(fontSize: 10, color: ColorResources.RATE_COLOR)),
      ],
    );
  }
}

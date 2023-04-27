import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/text_styles.dart';
import 'custom_images.dart';


class RateStars extends StatelessWidget {
  const RateStars(
      {Key? key, required this.rate, this.showRateNumber = true})
      : super(key: key);

  final int rate;
  final bool showRateNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children:[ ...List.generate(
            rate,
                (index) => customImageIconSVG(imageName: SvgImages.fillStar),
          ),
            ...List.generate(
             5- rate,
                  (index) => customImageIconSVG(imageName: SvgImages.emptyStar),
            )],
        ),
        if(showRateNumber)  Text("(${rate.toDouble()})",
            style: AppTextStyles.w400
                .copyWith(fontSize: 10, color: ColorResources.RATE_COLOR)),
      ],
    );
  }
}

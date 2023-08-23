import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/methods.dart';
import '../components/marquee_widget.dart';

class SelectedDaysOfWeekWidget extends StatelessWidget {
  const SelectedDaysOfWeekWidget(
      {Key? key,
      this.days,
      this.isLoading = false,
      this.startTime,
      this.endTime})
      : super(key: key);
  final List<String>? days;
  final String? startTime;
  final String? endTime;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SelectedDaysOfWeekWidgetShimmer()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    children: List.generate(
                        days?.length ?? 0,
                        (index) => SizedBox(
                              width: 50,
                              height: 40,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  customImageIconSVG(
                                      imageName: SvgImages.dayInCalenderIcon,
                                      height: 40,
                                      width: 50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Expanded(
                                          child: Text(
                                            days?[index] ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: AppTextStyles.w400.copyWith(
                                                fontSize: 10,
                                                color: Colors.black,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))),
              ),
              SizedBox(
                width: 24.w,
              ),
              Column(
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.alarm,
                      width: 35,
                      height: 35,
                      color: Styles.PRIMARY_COLOR),
                  const SizedBox(height: 8),
                  MarqueeWidget(
                    child: Text(
                      "${Methods.convertStringToTime(startTime, withFormat: true)}"
                      " - ${Methods.convertStringToTime(endTime, withFormat: true)}ً",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 10, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

class SelectedDaysOfWeekWidgetShimmer extends StatelessWidget {
  const SelectedDaysOfWeekWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
              children: List.generate(
                  3,
                  (index) => const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CustomShimmerContainer(
                          width: 50,
                          height: 40,
                        ),
                      ))),
        ),
        SizedBox(
          width: 24.w,
        ),
        Column(
          children: [
            customImageIconSVG(
                imageName: SvgImages.alarm,
                width: 35,
                height: 35,
                color: Styles.PRIMARY_COLOR),
            const SizedBox(height: 8),
            const CustomShimmerContainer(
              width: 100,
              height: 16,
            )
          ],
        ),
      ],
    );
  }
}

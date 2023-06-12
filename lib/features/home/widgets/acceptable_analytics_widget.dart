import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/half_circle_analytics_chart.dart';

class AcceptableAnalytics extends StatelessWidget {
  const AcceptableAnalytics({
    Key? key,
    required this.value,
    required this.color,
  }) : super(key: key);
  final num value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return  Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return
             Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: HalfCircleAnalyticsChart(
                [
                  if(provider.isLogin)
                    ChartData("Success progress", value.toDouble(), color),
                  ChartData(
                    "Failed progress",
                    100 - value.toDouble(),
                    ColorResources.HINT_COLOR,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    !provider.isLogin?"??":   "$value%",
                    style: AppTextStyles.w700.copyWith(
                        fontSize: 12,
                        height: 1,
                        color: ColorResources.SECOUND_PRIMARY_COLOR),
                  ),
                  Text(
                    "توافق",
                    style: AppTextStyles.w400
                        .copyWith(fontSize: 11, height: 1, color: color),
                  ),
                ],
              ),
            )
          ],
        );
      },
    )
    ;
  }
}

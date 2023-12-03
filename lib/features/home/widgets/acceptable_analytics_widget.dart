import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/half_circle_analytics_chart.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
import '../../auth/pages/login.dart';

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
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            if (!provider.isLogin) {
              CupertinoPopUpHelper.showCupertinoPopUp(
                  confirmTextButton: getTranslated("login", context),
                  onConfirm: () {
                    CustomNavigator.pop();
                    customShowModelBottomSheet(body: const Login());
                  },
                  title: "نسبة التوافق",
                  description:
                      "تظهر نسبة التوافق بعد تسجيل الدخول و اكمال بيانات وجهة العمل/الدوام (الوجهه النهائية)");
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: HalfCircleAnalyticsChart(
                  [
                    if (provider.isLogin)
                      ChartData("Success progress", value.toDouble(), color),
                    ChartData(
                      "Failed progress",
                      100 - value.toDouble(),
                      Styles.HINT_COLOR,
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
                      !provider.isLogin ? "??" : "${value.toStringAsFixed(1)}%",
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 12,
                          height: 1,
                          color: Styles.SECOUND_PRIMARY_COLOR),
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
          ),
        );
      },
    );
  }
}

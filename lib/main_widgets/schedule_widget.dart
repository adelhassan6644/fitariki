import 'package:fitariki/app/core/utils/app_strings.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../main_providers/schedule_provider.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({this.startPadding, Key? key}) : super(key: key);
  final double? startPadding;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(builder: (context, provider, _) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: startPadding ?? 0,
            ),
            ...List.generate(
              AppStrings.days.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: GestureDetector(
                    onTap: () => provider.onSelectDay(AppStrings.days[index]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: provider.checkSelectDay(AppStrings.days[index])
                              ? Styles.PRIMARY_COLOR
                              : Styles.PRIMARY_COLOR.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        AppStrings.days[index].dayName ?? "",
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 13,
                          height: 1.25,
                          color: provider.checkSelectDay(AppStrings.days[index])
                              ? Styles.WHITE_COLOR
                              : Styles.SECOUND_PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}

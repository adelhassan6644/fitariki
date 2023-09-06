import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../main_models/weak_model.dart';
import '../../../main_widgets/calender_widget.dart';

class TripDaysOnCalenderWidget extends StatelessWidget {
  const TripDaysOnCalenderWidget(
      {this.startDate, this.endDate, this.days, Key? key})
      : super(key: key);
  final DateTime? startDate, endDate;
  final List<WeekModel>? days;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: ExpansionTileWidget(
        iconColor: Styles.SECOUND_PRIMARY_COLOR,
        title: getTranslated("trip_details", context),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  getTranslated("start_of_duration", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(startDate!.dateFormat(format: "d MMM yyyy"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 13,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  getTranslated("end_of_duration", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(endDate!.dateFormat(format: "d MMM yyyy"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 13,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          CalenderWidget(startDate: startDate!, endDate: endDate!, days: days!),
        ],
      ),
    );
  }
}

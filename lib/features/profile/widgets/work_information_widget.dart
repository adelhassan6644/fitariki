import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_address_picker.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../helpers/date_time_picker.dart';
import '../../../main_widgets/schedule_widget.dart';
import '../provider/profile_provider.dart';

class WorkInformationWidget extends StatelessWidget {
  const WorkInformationWidget({required this.provider, Key? key, required this.fromLogin})
      : super(key: key);
  final ProfileProvider provider;
  final bool fromLogin;


  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, _) {
      return ExpansionTileWidget(
        title: getTranslated("other_information", context),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated("days", context),
                style: AppTextStyles.w600.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const ScheduleWidget(),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated("time", context),
                style: AppTextStyles.w600.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  getTranslated("start", context),
                  style: AppTextStyles.w600.copyWith(fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () => customShowModelBottomSheet(
                  body: DateTimePicker(
                    mode: CupertinoDatePickerMode.time,
                    startDateTime: provider.startTime,
                    valueChanged: provider.onSelectStartTime,
                    label: getTranslated("start_time", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                      provider.startTime
                          .dateFormat(format: "mm : hh aa")
                          .replaceAll("AM", "صباحاً")
                          .replaceAll("PM", "مساءً"),
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 13,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  getTranslated("end", context),
                  style: AppTextStyles.w600.copyWith(fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () => customShowModelBottomSheet(
                  body: DateTimePicker(
                    mode: CupertinoDatePickerMode.time,
                    startDateTime: provider.endTime,
                    valueChanged: provider.onSelectEndTime,
                    label: getTranslated("end_time", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                      provider.endTime
                          .dateFormat(format: "mm : hh aa")
                          .replaceAll("AM", "صباحاً")
                          .replaceAll("PM", "مساءً"),
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 13,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          CustomAddressPicker(
            hint: getTranslated(
                "locate_your_work_study_location_on_the_map", context),
            onPicked: provider.onSelectEndLocation,
            location: provider.endLocation,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Styles.LIGHT_BORDER_COLOR, width: 1),
                borderRadius: BorderRadius.circular(8)),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}

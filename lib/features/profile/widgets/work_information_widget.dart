import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/marquee_widget.dart';
import '../../../helpers/date_time_picker.dart';
import '../../../main_models/base_model.dart';
import '../../../main_widgets/scchedule_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/profile_provider.dart';

class WorkInformationWidget extends StatefulWidget {
  const WorkInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final ProfileProvider provider;

  @override
  State<WorkInformationWidget> createState() => _WorkInformationWidgetState();
}

class _WorkInformationWidgetState extends State<WorkInformationWidget> {
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
                      color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
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
                      color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
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
          GestureDetector(
            onTap: () {
              CustomNavigator.push(Routes.PICK_LOCATION,
                  arguments: BaseModel(
                      valueChanged: provider.onSelectEndLocation,
                      object: provider.endLocation));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorResources.LIGHT_BORDER_COLOR, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: MarqueeWidget(
                      child: Text(
                        provider.endLocation?.address ??
                            "حدد مكان دوامك/دراستك بالخريطه",
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: provider.endLocation?.address == null
                                ? ColorResources.DISABLED
                                : ColorResources.SECOUND_PRIMARY_COLOR,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  customImageIconSVG(imageName: SvgImages.map)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}

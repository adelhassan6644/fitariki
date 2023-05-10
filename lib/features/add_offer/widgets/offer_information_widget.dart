import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/date_time_picker.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../main_widgets/custom_images.dart';
import '../../../main_widgets/custom_show_model_bottom_sheet.dart';
import '../../../main_widgets/expansion_tile_widget.dart';
import '../../../main_widgets/marquee_widget.dart';
import '../../../main_widgets/price_text_field.dart';
import '../../../main_widgets/schedule/scchedule_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/add_offer_provider.dart';

class OfferInformationWidget extends StatefulWidget {
  const OfferInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final AddOfferProvider provider;

  @override
  State<OfferInformationWidget> createState() => _OfferInformationWidgetState();
}

class _OfferInformationWidgetState extends State<OfferInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("other_information", context),
      children: [
        const ScheduleWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///start of time
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("start_time", context),
                style: AppTextStyles.w400.copyWith(fontSize: 14),
              ),
            ),
            GestureDetector(
              onTap: () => customShowModelBottomSheet(
                body: DateTimePicker(
                  mode: CupertinoDatePickerMode.time,
                  startDateTime: widget.provider.startTime,
                  valueChanged: widget.provider.onSelectStartTime,
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
                    widget.provider.startTime.dateFormat(format: "mm : hh aa"),
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 13,
                    )),
              ),
            ),
            // const SizedBox(
            //   width: 4,
            // ),
            // Container(
            //   width: 160,
            //   decoration: BoxDecoration(
            //       color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
            //       borderRadius: BorderRadius.circular(6)),
            //   padding: const EdgeInsets.all(2),
            //   child: Row(
            //     children: List.generate(
            //         widget.provider.timeZones.length,
            //         (index) => Expanded(
            //               child: TabWidget(
            //                   backGroundColor: ColorResources.PRIMARY_COLOR,
            //                   innerVPadding: 2,
            //                   title: getTranslated(
            //                       widget.provider.timeZones[index], context),
            //                   isSelected: widget.provider.timeZones[index] ==
            //                       widget.provider.startTimeZone,
            //                   onTab: () => widget.provider
            //                       .selectedStartTimeZone(
            //                           widget.provider.timeZones[index])),
            //             )),
            //   ),
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///end of time
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("end_time", context),
                style: AppTextStyles.w400.copyWith(fontSize: 14),
              ),
            ),
            GestureDetector(
              onTap: () => customShowModelBottomSheet(
                body: DateTimePicker(
                  mode: CupertinoDatePickerMode.time,
                  startDateTime: widget.provider.endTime,
                  valueChanged: widget.provider.onSelectEndTime,
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
                    widget.provider.endTime.dateFormat(format: "mm : hh aa"),
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 13,
                    )),
              ),
            ),
            // const SizedBox(
            //   width: 4,
            // ),
            // Container(
            //   width: 160,
            //   decoration: BoxDecoration(
            //       color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
            //       borderRadius: BorderRadius.circular(6)),
            //   padding: const EdgeInsets.all(2),
            //   child: Row(
            //     children: List.generate(
            //         widget.provider.timeZones.length,
            //         (index) => Expanded(
            //               child: TabWidget(
            //                   backGroundColor: ColorResources.PRIMARY_COLOR,
            //                   innerVPadding: 2,
            //                   title: getTranslated(
            //                       widget.provider.timeZones[index], context),
            //                   isSelected: widget.provider.timeZones[index] ==
            //                       widget.provider.endTimeZone,
            //                   onTab: () => widget.provider.selectedEndTimeZone(
            //                       widget.provider.timeZones[index])),
            //             )),
            //   ),
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///start of duration
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
            GestureDetector(
              onTap: () => customShowModelBottomSheet(
                body: DateTimePicker(
                  startDateTime: widget.provider.startDate,
                  valueChanged: widget.provider.onSelectStartDate,
                  label: getTranslated("start_of_duration", context),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                    widget.provider.startDate.dateFormat(format: "yyyy MMM d"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 13,
                    )),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///end of duration
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                getTranslated("end_of_duration", context),
                style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => customShowModelBottomSheet(
                body: DateTimePicker(
                  startDateTime: widget.provider.startDate,
                  valueChanged: widget.provider.onSelectEndDate,
                  label: getTranslated("end_of_duration", context),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                    widget.provider.endDate.dateFormat(format: "yyyy MMM d"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 13,
                    )),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///duration
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("duration", context),
                style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                  color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  "${Methods.diffBtw2Dates(startDate: widget.provider.startDate, endDate: widget.provider.endDate)} ${getTranslated("days", context).replaceAll("ال", "")}",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///Minimum price
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("minimum_price", context),
                style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: PriceTextFormField(
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                initialValue: widget.provider.minPrice,
                inputType: TextInputType.number,
                hint: "00000",
                onChanged: (v) {
                  widget.provider.minPrice = v;
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///Maximum price
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated("maximum_price", context),
                style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: PriceTextFormField(
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                inputType: TextInputType.number,
                initialValue: widget.provider.maxPrice,
                hint: "00000",
                onChanged: (v) {
                  widget.provider.maxPrice = v;
                },
                validation: (v) {
                  if (double.parse(v ?? "0") >
                      double.parse(widget.provider.minPrice ?? "0")) {
                    return getTranslated(
                        "max_price_must_be_more_than_min_price", context);
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: context.width,
            color: ColorResources.BORDER_COLOR,
            child: const SizedBox(),
          ),
        ),

        ///end of location
        GestureDetector(
          onTap: () {
            CustomNavigator.push(Routes.Pick_Location,
                arguments: widget.provider.onSelectEndLocation);
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
                      widget.provider.endLocation?.address ??
                          "حدد مكان دوامك/دراستك بالخريطه",
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                          color: widget.provider.endLocation?.address == null
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
      ],
    );
  }
}

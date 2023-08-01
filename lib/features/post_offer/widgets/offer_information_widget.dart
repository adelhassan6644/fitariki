import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/checkbox_list_tile.dart';
import '../../../components/custom_address_picker.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/price_text_field.dart';
import '../../../helpers/date_time_picker.dart';
import '../../../main_widgets/scchedule_widget.dart';
import '../provider/post_offer_provider.dart';

class OfferInformationWidget extends StatefulWidget {
  const OfferInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final PostOfferProvider provider;

  @override
  State<OfferInformationWidget> createState() => _OfferInformationWidgetState();
}

class _OfferInformationWidgetState extends State<OfferInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("other_information", context),
      childrenPadding: 4,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                const ScheduleWidget(startPadding: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 1,
                          width: context.width,
                          color: Styles.BORDER_COLOR,
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  widget.provider.startTime
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 1,
                          width: context.width,
                          color: Styles.BORDER_COLOR,
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  widget.provider.endTime
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 1,
                          width: context.width,
                          color: Styles.BORDER_COLOR,
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
                                minDateTime: DateTime.now(),
                                valueChanged: widget.provider.onSelectStartDate,
                                label:
                                    getTranslated("start_of_duration", context),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  widget.provider.startDate
                                      .dateFormat(format: "d MMM yyyy"),
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
                          color: Styles.BORDER_COLOR,
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
                                startDateTime: widget.provider.endDate,
                                minDateTime: DateTime.now(),
                                valueChanged: widget.provider.onSelectEndDate,
                                label:
                                    getTranslated("end_of_duration", context),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  widget.provider.endDate
                                      .dateFormat(format: "d MMM yyyy"),
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
                          color: Styles.BORDER_COLOR,
                          child: const SizedBox(),
                        ),
                      ),

                      ///duration
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated("delivery_days", context),
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(4)),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                "${widget.provider.counts?.count ?? 0}",
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
                          color: Styles.BORDER_COLOR,
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
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
                          color: Styles.BORDER_COLOR,
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
                              ],
                              inputType: TextInputType.number,
                              initialValue: widget.provider.maxPrice,
                              hint: "00000",
                              onChanged: (v) {
                                widget.provider.maxPrice = v;
                              },
                              validation: (v) {
                                if (double.parse(v ?? "0") >
                                    double.parse(
                                        widget.provider.minPrice ?? "0")) {
                                  return getTranslated(
                                      "max_price_must_be_more_than_min_price",
                                      context);
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
                          color: Styles.BORDER_COLOR,
                          child: const SizedBox(),
                        ),
                      ),

                      CustomAddressPicker(
                        hint: getTranslated(
                            "locate_your_work_study_location_on_the_map",
                            context),
                        onPicked: widget.provider.onSelectEndLocation,
                        location: widget.provider.endLocation,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ),
                        child: CheckBoxListTile(
                          title:
                              getTranslated("my_work_study_location", context),
                          onChange: widget.provider.onSelect1,
                          check: widget.provider.sameDestination,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

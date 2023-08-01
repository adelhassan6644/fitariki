import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_show_model_bottom_sheet.dart';
import '../../../components/price_text_field.dart';
import '../../../helpers/date_time_picker.dart';
import '../provider/add_request_provider.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({required this.provider,required this.offerStartDate, Key? key}) : super(key: key);
  final AddRequestProvider provider;
  final DateTime offerStartDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Styles.WHITE_COLOR,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              spreadRadius: 0,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
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
                    startDateTime: provider.startDate,
                    minDateTime: offerStartDate,
                    valueChanged: provider.onSelectStartDate,
                    label: getTranslated("start_of_duration", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                      provider.startDate
                          .dateFormat(format: "d MMM yyyy",),
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
                    startDateTime: provider.endDate,
                    minDateTime: offerStartDate,
                    valueChanged: provider.onSelectEndDate,
                    label: getTranslated("end_of_duration", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                      provider.endDate
                          .dateFormat(format: "d MMM yyyy", lang: "ar-SA"),
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
                  getTranslated("duration", context),
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
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    "${provider.duration}",
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
                  inputType: TextInputType.number,
                  hint: "00000",
                  controller: provider.minPrice,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

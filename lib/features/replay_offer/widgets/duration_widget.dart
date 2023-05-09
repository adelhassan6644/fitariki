import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/date_time_picker.dart';
import '../../../main_widgets/custom_show_model_bottom_sheet.dart';
import '../provider/replay_offer_provider.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({required this.provider, Key? key}) : super(key: key);
  final ReplayOfferProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          color: ColorResources.WHITE_COLOR,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 5.0,
                spreadRadius: -1,
                offset: const Offset(0, 6))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
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
                    valueChanged: provider.onSelectStartDate,
                    label: getTranslated("start_of_duration", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child:
                      Text(provider.startDate.dateFormat(format: "yyyy MMM d"),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 13,
                          )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: context.width,
              color: ColorResources.BORDER_COLOR,
              child: const SizedBox(),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
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
                    valueChanged: provider.onSelectEndDate,
                    label: getTranslated("end_of_duration", context),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(provider.endDate.dateFormat(format: "yyyy MMM d"),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 13,
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: context.width,
              color: ColorResources.BORDER_COLOR,
              child: const SizedBox(),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
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
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.add,
                        color: ColorResources.SECOUND_PRIMARY_COLOR,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                            color: ColorResources.DISABLED,
                            border: Border.all(
                                color: Colors.transparent, width: 0.5.h),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            "5",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.w500.copyWith(
                              fontSize: 13,
                              color: ColorResources.WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.remove,
                        color: ColorResources.SECOUND_PRIMARY_COLOR,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: context.width,
              color: ColorResources.BORDER_COLOR,
              child: const SizedBox(),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Text(
                  getTranslated("price", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(4)),
                child: Text("200",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 13,
                    )),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                getTranslated("sar", context),
                style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

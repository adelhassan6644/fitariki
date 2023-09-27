import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/features/my_trips/provider/previous_trip_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class InvoiceDetailsWidget extends StatelessWidget {
  const InvoiceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviousTripDetailsProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Divider(
              thickness: 1,
              color: Styles.LIGHT_BORDER_COLOR,
            ),
          ),

          ///Payment details
          Visibility(
            visible: !provider.isDriver,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated("payment", context),
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated("trip_amount", context),
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "${provider.tripDetails?.amount ?? ""} ${getTranslated("sar", context)}",
                            style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${getTranslated("tax", context)} ${(provider.tripDetails?.taxPercentage ?? 0)}%",
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "${(provider.tripDetails?.tax ?? 0).toStringAsFixed(2)} ${getTranslated("sar", context)}",
                            style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${getTranslated("service_costs", context)} ${(provider.tripDetails?.serviceCostPercentage ?? 0)}%",
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "${(provider.tripDetails?.serviceCost ?? 0).toStringAsFixed(2)} ${getTranslated("sar", context)}",
                            style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: provider.tripDetails?.discount != null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getTranslated("discount", context),
                                    style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  "- ${provider.tripDetails?.discount ?? ""} ${getTranslated("sar", context)}",
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 14, color: Styles.RED_COLOR),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Divider(
                    thickness: 1,
                    color: Styles.LIGHT_BORDER_COLOR,
                  ),
                ),
              ],
            ),
          ),

          ///Final amount
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("absence_days", context),
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "${provider.tripDetails?.numOfCancelTrips ?? ""} ${getTranslated("day", context)}",
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("absence_cost", context),
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "- ${provider.tripDetails?.cancelValue ?? ""} ${getTranslated("sar", context)}",
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 14, color: Styles.RED_COLOR),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("final_amount", context),
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "${provider.tripDetails?.total ?? ""} ${getTranslated("sar", context)}",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///Open Invoice
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 24.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: CustomButton(
              onTap:provider.tripDetails?.invoice !=null? () => CustomNavigator.push(Routes.PDF,
                  arguments: provider.tripDetails?.invoice ?? ""):null,
              text:provider.tripDetails?.invoice==null? getTranslated("not_invoice", context):getTranslated("preview_invoice", context),
              backgroundColor: Styles.WHITE_COLOR,
              textColor: Styles.PRIMARY_COLOR,
              withBorderColor: true,
            ),
          ),
        ],
      );
    });
  }
}

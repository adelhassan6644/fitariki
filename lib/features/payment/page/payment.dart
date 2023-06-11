import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../main_widgets/shimmer_widgets/payment_shimmer_widget.dart';
import '../../../main_widgets/user_card.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../widgets/coupon_widget.dart';
import '../widgets/payment_details_widget.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              CustomAppBar(
                title: getTranslated("payment", context),
              ),
              Consumer<RequestDetailsProvider>(builder: (_, provider, child) {
                return provider.isLoading
                    ? const PaymentShimmerShimmer()
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListAnimator(
                                data: [
                                  ///user card
                                  UserCard(
                                    withAnalytics: false,
                                    userId: provider.requestModel?.driverId,
                                    name: provider
                                        .requestModel?.driverModel?.firstName,
                                    male: provider.requestModel?.driverModel
                                            ?.gender ==
                                        0,
                                    national: provider.requestModel?.driverModel
                                        ?.national?.niceName,
                                    createdAt:
                                        provider.requestModel?.createdAt ??
                                            DateTime.now(),
                                    days: provider
                                        .requestModel?.offer?.offerDays!
                                        .map((e) => e.dayName)
                                        .toList()
                                        .join(", "),
                                    duration: provider.requestModel?.duration
                                        .toString(),
                                    priceRange:
                                        "${provider.requestModel?.price ?? 0} ${getTranslated("sar", context)}",
                                    timeRange:
                                        "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w),
                                    child: Text(
                                      getTranslated("coupon", context),
                                      style: AppTextStyles.w600.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const CouponWidget(),
                                  // PaymentMethodWidget(),
                                  const PaymentDetailsWidget()
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !provider.isLoading,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w),
                                child: Consumer<PaymentProvider>(
                                    builder: (_, provider, child) {
                                  return CustomButton(
                                    isLoading: provider.isCheckOut,
                                    text: getTranslated("check_out", context),
                                    onTap: () => provider.checkOut(),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            )
                          ],
                        ),
                      );
              }),
            ],
          )),
    );
  }
}

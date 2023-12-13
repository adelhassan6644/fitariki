import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:fitariki/features/payment/widgets/wallet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/shimmer_widgets/payment_shimmer_widget.dart';
import '../../../main_widgets/user_card.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../widgets/coupon_widget.dart';
import '../widgets/payment_details_widget.dart';

class Payment extends StatefulWidget {
  final bool isFromMyTrips;
  final int? id;
  const Payment({super.key, this.isFromMyTrips = false, this.id});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.id != null) {
        sl<RequestDetailsProvider>().getRequestDetails(id: widget.id!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("payment", context),
        ),
        body: Column(
          children: [
            Consumer<RequestDetailsProvider>(builder: (_, provider, child) {
              return (provider.isLoading)
                  ? const PaymentShimmerShimmer()
                  : Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListAnimator(
                              data: [
                                ///user card
                                Visibility(
                                  visible: widget.isFromMyTrips,
                                  child: UserCard(
                                    withAnalytics: false,
                                    userId: provider
                                            .requestModel?.driverModel?.id ??
                                        provider.requestModel?.offer
                                            ?.driverModel?.id,
                                    name: provider.requestModel?.driverModel
                                            ?.firstName ??
                                        provider.requestModel?.offer
                                            ?.driverModel?.firstName,
                                    male: (provider.requestModel?.driverModel
                                                ?.gender ??
                                            provider.requestModel?.offer
                                                ?.driverModel?.gender) ==
                                        0,
                                    image: provider
                                            .requestModel?.driverModel?.image ??
                                        provider.requestModel?.offer
                                            ?.driverModel?.image,
                                    national: provider.requestModel?.driverModel
                                            ?.national?.niceName ??
                                        provider.requestModel?.offer
                                            ?.driverModel?.national?.niceName,
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
                                ),

                                Visibility(
                                  visible: !widget.isFromMyTrips,
                                  child: UserCard(
                                    withAnalytics: false,
                                    userId: provider.requestModel?.driverId,
                                    name: provider
                                        .requestModel?.driverModel?.firstName,
                                    image: provider
                                        .requestModel?.driverModel?.image,
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
                                ),

                                ///Type of ride
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT.w,
                                      vertical:
                                          Dimensions.PADDING_SIZE_DEFAULT.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getTranslated("ride_type", context),
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.w600.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        Methods.getOfferType(
                                            provider.requestModel?.offerType ??
                                                provider.requestModel?.offer
                                                    ?.offerType ??
                                                1),
                                        textAlign: TextAlign.end,
                                        style: AppTextStyles.w400.copyWith(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                ///Coupon
                                const CouponWidget(),

                                ///Wallet Widget
                                const WalletWidget(),
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
        ),
      ),
    );
  }
}

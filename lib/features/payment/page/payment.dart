import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../main_widgets/user_card.dart';
import '../../request_details/provider/request_details_provider.dart';
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
                return Expanded(
                  child: ListAnimator(
                    data: [
                      ///user card
                      UserCard(
                        withAnalytics: false,
                        userId: provider.requestModel?.driverId,
                        name: provider.requestModel?.driverModel?.firstName,
                        male: provider.requestModel?.driverModel?.gender == 0,
                        national: provider
                            .requestModel?.driverModel?.national?.niceName,
                        createdAt:
                            provider.requestModel?.createdAt ?? DateTime.now(),
                        days: provider.requestModel?.offer?.offerDays!
                            .map((e) => e.dayName)
                            .toList()
                            .join(", "),
                        duration: provider.requestModel?.duration.toString(),
                        priceRange:
                            "${provider.requestModel?.price ?? 0} ${getTranslated("sar", context)}",
                        timeRange:
                            "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: Text(
                          getTranslated("coupon", context),
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Consumer<PaymentProvider>(
                          builder: (_, paymentProvider, child) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                            child: Row(children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: paymentProvider.discountCode,
                                  hint: "****",
                                  edge: const BorderRadius.only(
                                    topRight: Radius.circular(
                                      Dimensions.RADIUS_DEFAULT,
                                    ),
                                    bottomRight: Radius.circular(
                                      Dimensions.RADIUS_DEFAULT,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  if (paymentProvider
                                          .discountCode.text.isNotEmpty &&
                                      !paymentProvider.isLoading) {
                                    if (paymentProvider.discount < 1) {
                                      paymentProvider
                                          .applyCoupon(
                                        coupon: paymentProvider
                                            .discountCode.text
                                            .trim(),
                                      )
                                          .then((discount) {
                                        if (discount > 0) {
                                          showToast(
                                            getTranslated(
                                                "coupon_code_applied_successfully",
                                                context),
                                          );
                                        } else {
                                          // showCustomSnackBar(
                                          //     message: "fail", context: context);
                                        }
                                      });
                                    } else {
                                      paymentProvider.removeCouponData(true);
                                    }
                                  } else if (paymentProvider
                                      .discountCode.text.isEmpty) {
                                    showToast(
                                        getTranslated("enter_coupon", context));
                                  }
                                },
                                child: Container(
                                  width: 100.w,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 16.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(
                                        Dimensions.RADIUS_DEFAULT,
                                      ),
                                      bottomLeft: Radius.circular(
                                        Dimensions.RADIUS_DEFAULT,
                                      ),
                                    ),
                                  ),
                                  child: paymentProvider.discount <= 0
                                      ? !paymentProvider.isLoading
                                          ? Text(
                                              getTranslated("apply", context),
                                              style: AppTextStyles.w500
                                                  .copyWith(
                                                      color: ColorResources
                                                          .WHITE_COLOR,
                                                      fontSize: 14),
                                            )
                                          : const SpinKitThreeBounce(
                                              color: ColorResources.WHITE_COLOR,
                                              size: 20,
                                            )
                                      : const Icon(Icons.clear,
                                          color: Colors.white),
                                ),
                              ),
                            ]));
                      }),
                      // PaymentMethodWidget(),
                      const PaymentDetailsWidget()
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Consumer<PaymentProvider>(builder: (_, provider, child) {
                  return CustomButton(
                    isLoading: provider.isCheckOut,
                    text: getTranslated("check_out", context),
                    onTap: () => provider.checkOut(),
                  );
                }),
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          )),
    );
  }
}

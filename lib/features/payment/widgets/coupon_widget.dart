import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/payment_provider.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            child: Text(
              getTranslated("coupon", context),
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          Consumer<PaymentProvider>(builder: (_, paymentProvider, child) {
            return Row(children: [
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
                  if (paymentProvider.discountCode.text.isNotEmpty &&
                      !paymentProvider.isLoading) {
                    if (paymentProvider.discount < 1) {
                      paymentProvider
                          .applyCoupon(
                        coupon: paymentProvider.discountCode.text.trim(),
                      )
                          .then((discount) {
                        if (discount > 0) {
                          showToast(
                            getTranslated(
                                "coupon_code_applied_successfully", context),
                          );
                        } else {
                          // showCustomSnackBar(
                          //     message: "fail", context: context);
                        }
                      });
                    } else {
                      paymentProvider.removeCouponData(true);
                    }
                  } else if (paymentProvider.discountCode.text.isEmpty) {
                    showToast(getTranslated("enter_coupon", context));
                  }
                },
                child: Container(
                  width: 100.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: paymentProvider.discount <= 0
                        ? !paymentProvider.isLoading
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.2)
                        : Styles.ACTIVE,
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
                              style: AppTextStyles.w500.copyWith(
                                  color: Styles.WHITE_COLOR,
                                  fontSize: 14),
                            )
                          : const SpinKitThreeBounce(
                              color: Styles.PRIMARY_COLOR,
                              size: 20,
                            )
                      : const Icon(Icons.clear, color: Colors.white),
                ),
              ),
            ]);
          }),
        ],
      ),
    );
  }
}

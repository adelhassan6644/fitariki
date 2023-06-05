import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../main_widgets/user_card.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../../success/model/success_model.dart';
import '../widgets/payment_details_widget.dart';
import '../widgets/payment_method_widget.dart';

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
                        userId: provider.isDriver
                            ? provider.requestModel?.clientId
                            : provider.requestModel?.driverId,
                        name: provider.isDriver
                            ? provider.requestModel?.clientModel?.firstName
                            : provider.requestModel?.driverModel?.firstName,
                        male: provider.isDriver
                            ? provider.requestModel?.clientModel?.gender == 0
                            : provider.requestModel?.driverModel?.gender == 0,
                        national: provider.isDriver
                            ? provider.requestModel?.clientModel?.national?.niceName
                            : provider.requestModel?.driverModel?.national?.niceName,
                        createdAt: provider.requestModel?.createdAt ?? DateTime.now(),
                        days: provider.requestModel?.offer?.offerDays!.map((e) => e.dayName).toList().join(", "),
                        duration: provider.requestModel?.duration.toString(),
                        priceRange: "${provider.requestModel?.price ?? 0} ريال",
                        followers:provider.requestModel!.followers!.isNotEmpty? "${ provider.requestModel?.followers?.length}" : null,
                        timeRange: "${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].startTime, withFormat: true)}: ${Methods.convertStringToTime(provider.requestModel?.offer?.offerDays?[0].endTime, withFormat: true)}",
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: Text(
                          getTranslated("discountـcode", context),
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Consumer<PaymentProvider>(builder: (_, paymentProvider, child) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                            child:    Row(children: [
                              Expanded(
                                child: CustomTextFormField(
                                  // controller: paymentProvider.discountCode,
                                  controller: paymentProvider.discountCode,
                                  hint: "****",
                                ),

                                // TextField(
                                //   controller: _couponController,
                                //   decoration: InputDecoration(
                                //     hintText: "رمز القسيمة",
                                //     isDense: true,
                                //     filled: true,
                                //     enabled: coupon.discount == 0,
                                //     fillColor: Theme.of(context).primaryColor,
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.horizontal(
                                //         left: Radius.circular(0),
                                //         right: Radius.circular(10),
                                //       ),
                                //       borderSide: BorderSide.none,
                                //     ),
                                //   ),
                                // ),
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
                                            "تم تطبيق رمز القسيمة بنجاح",);
                                        } else {
                                          // showCustomSnackBar(
                                          //     message: "fail", context: context);
                                        }
                                      });
                                    } else {
                                      paymentProvider.removeCouponData(true);
                                    }
                                  } else if (paymentProvider.discountCode.text.isEmpty) {
                                    showToast( 'ادخل رمز القسيمة',

                                    );
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: paymentProvider.discount <= 0
                                      ? !paymentProvider.isLoading
                                      ? Text(
                                    "تطبيق",
                                    style: TextStyle(color: Colors.white),
                                  )
                                      : CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white))
                                      : Icon(Icons.clear, color: Colors.white),
                                ),
                              ),
                            ])
                          );
                        }
                      ),
                      // PaymentMethodWidget(),
                      PaymentDetailsWidget(

                      )
                    ],
                  ),
                );
              }
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Consumer<PaymentProvider>(builder: (_, provider, child) {
                return CustomButton(
                  text: getTranslated("complete_theـpaymentـprocess", context),
                  onTap: () {
                    provider.checkOut();
                  },
                );
              }
              ),
            ),
            SizedBox(
              height: 24.h,
            )
          ],
        )
      ),
    );
  }
}

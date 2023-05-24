import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../main_widgets/user_card.dart';
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
        child: Consumer<PaymentProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              CustomAppBar(
                title: getTranslated("payment", context),
              ),
              Expanded(
                child: ListAnimator(
                  data: [
                    const UserCard(
                      withAnalytics: false,
                      days: "الأحد، الإثنين، الثلاثاء",
                      daysNum: "10",
                      priceRange: "200",
                      createdAt: "4",
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: CustomTextFormField(
                        controller: provider.discountCode,
                        hint: "****",
                      ),
                    ),
                    PaymentMethodWidget(
                      paymentProvider: provider,
                    ),
                    PaymentDetailsWidget(
                      paymentProvider: provider,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: CustomButton(
                  text: getTranslated("complete_theـpaymentـprocess", context),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          );
        }),
      ),
    );
  }
}

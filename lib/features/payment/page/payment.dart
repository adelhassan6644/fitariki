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
                            child: CustomTextFormField(
                              controller: paymentProvider.discountCode,
                              hint: "****",
                            ),
                          );
                        }
                      ),
                      PaymentMethodWidget(),
                      PaymentDetailsWidget(
                        price: provider.requestModel!.price!,
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
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isCongrats: true,
                            isReplace: true,
                            routeName: Routes.REQUEST_DETAILS,
                            title: "محمد م...",
                            btnText: getTranslated("trip", context),
                            description:"تم دفع تكاليف الرحله بنجاح مع كابتن محمد م..."));
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

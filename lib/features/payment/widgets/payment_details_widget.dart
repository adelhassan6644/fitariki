import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class PaymentDetailsWidget extends StatefulWidget {
  const PaymentDetailsWidget({ Key? key})
      : super(key: key);

  @override
  State<PaymentDetailsWidget> createState() => _PaymentDetailsWidgetState();
}

class _PaymentDetailsWidgetState extends State<PaymentDetailsWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero,(){

      Provider.of<PaymentProvider>(context,listen: false).removeCouponData(true);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<PaymentProvider>(builder: (_, paymentProvider, child) {

      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated("payment_details", context),
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
                  "${paymentProvider.offerPrice} ريال",
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
                    "${getTranslated("tax", context)} 15%",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  "${paymentProvider.tax} ريال",
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
                    "${getTranslated("service_costs", context)} ",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  "${paymentProvider.serviceCost} ريال",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ) ,
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${getTranslated("discount", context)}",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  "${paymentProvider.discount} ريال",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ) ,  SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${getTranslated("Total", context)} ",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  "${paymentProvider.total} ريال",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    );
  }
}

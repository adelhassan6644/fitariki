import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({required this.price, Key? key})
      : super(key: key);
  final double price;

  @override
  Widget build(BuildContext context) {
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
                "$price ريال",
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
                "15 ريال",
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
                  "${getTranslated("service_costs", context)} 15%",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                "15 ريال",
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
}

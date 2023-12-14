import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({ Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("payment_method", context),
            style: AppTextStyles.w600.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8.h,
          )
        ],
      ),
    );
  }
}

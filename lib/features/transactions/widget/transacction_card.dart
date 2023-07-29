import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/features/transactions/model/transactions_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transactionItem})
      : super(key: key);
  final TransactionItem transactionItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Styles.LIGHT_GREY_BORDER, width: 1.h))),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: customImageIconSVG(
                imageName: SvgImages.withdraw, height: 40, width: 40),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${getTranslated("service_costs", context)} :",
                          style: AppTextStyles.w400.copyWith(
                              color: Styles.DETAILS_COLOR,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "${transactionItem.amount ?? 0} ${getTranslated("sar", context)}",
                          maxLines: 1,
                          style: AppTextStyles.w400.copyWith(
                              color: Styles.PRIMARY_COLOR,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${getTranslated("payment_method", context)} :",
                          style: AppTextStyles.w400.copyWith(
                              color: Styles.DETAILS_COLOR,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          transactionItem.paymentMethod ?? "",
                          maxLines: 1,
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 14,
                              color: Styles.SECOUND_PRIMARY_COLOR,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomButton(
                onTap: () => CustomNavigator.push(Routes.PDF,
                    arguments: transactionItem.invoice ?? ""),
                text: getTranslated("invoice", context),
                radius: 100,
                width: 100,
                textSize: 12,
                height: 30,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                transactionItem.createdAt!.dateFormat(format: 'dd MMM yyyy'),
                maxLines: 1,
                style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                    color: Styles.DETAILS_COLOR,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          )
        ],
      ),
    );
  }
}

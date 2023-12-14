import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/animated_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';

class PaymentShimmerShimmer extends StatelessWidget {
  const PaymentShimmerShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        data: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: CustomShimmerContainer(
              width: context.width,
              height: 126.h,
              radius: 8,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              getTranslated("coupon", context),
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: const CustomShimmerContainer(
                height: 40,
                radius: 8,
              )),
          Padding(
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
                    const CustomShimmerContainer(
                      height: 15,
                      radius: 8,
                      width: 100,
                    )
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
                    const CustomShimmerContainer(
                      height: 15,
                      radius: 8,
                      width: 100,
                    )
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
                    const CustomShimmerContainer(
                      height: 15,
                      radius: 8,
                      width: 100,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("discount", context),
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const CustomShimmerContainer(
                      height: 15,
                      radius: 8,
                      width: 100,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getTranslated("total", context),
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const CustomShimmerContainer(
                      height: 15,
                      radius: 8,
                      width: 100,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

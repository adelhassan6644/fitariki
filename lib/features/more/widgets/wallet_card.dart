import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({this.availableBalance,Key? key, this.pendingBalance}) : super(key: key);
  final double? availableBalance;  final double? pendingBalance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(image: AssetImage(Images.pronzeBG,),fit: BoxFit.fitHeight)),
            child: customImageIconSVG(
                imageName: SvgImages.medal,
                height: 24,
                width: 24,
                color: ColorResources.WHITE_COLOR),
          ),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          flex: 3,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: ColorResources.DISABLED,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                customImageIconSVG(
                    imageName: SvgImages.wallet,
                    height: 24,
                    width: 24,
                    color: ColorResources.WHITE_COLOR),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: pendingBalance?.toStringAsFixed(2)??"",
                          style: AppTextStyles.w700.copyWith(
                              fontSize: 12,
                              height: 1,
                              color: ColorResources.WHITE_COLOR),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${getTranslated("sar", context)}',
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  height: 1,
                                  color: ColorResources.WHITE_COLOR),
                            ),
                          ],
                        ),
                      ),
                      Text(getTranslated("pending", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, color: ColorResources.WHITE_COLOR)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          flex: 4,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: ColorResources.PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                customImageIconSVG(
                    imageName: SvgImages.wallet,
                    height: 24,
                    width: 24,
                    color: ColorResources.WHITE_COLOR),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: availableBalance?.toStringAsFixed(2),
                          style: AppTextStyles.w700.copyWith(
                              fontSize: 12,
                              height: 1,
                              color: ColorResources.WHITE_COLOR),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${getTranslated("sar", context)}',
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  height: 1,
                                  color: ColorResources.WHITE_COLOR),
                            ),
                          ],
                        ),
                      ),
                      Text(getTranslated("wallet_available", context),
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, color: ColorResources.WHITE_COLOR)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(image: AssetImage(Images.pronzeBG))),
          child: customImageIconSVG(
              imageName: SvgImages.medal,
              height: 24,
              width: 24,
              color: ColorResources.WHITE_COLOR),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Container(
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
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '200',
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 12,
                          height: 1,
                          color: ColorResources.WHITE_COLOR),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ريال',
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
              )
            ],
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Container(
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
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '200',
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 12,
                          height: 1,
                          color: ColorResources.WHITE_COLOR),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ريال',
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
              )
            ],
          ),
        ),
      ],
    );
  }
}

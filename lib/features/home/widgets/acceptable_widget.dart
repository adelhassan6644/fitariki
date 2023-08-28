import 'package:fitariki/app/core/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../provider/home_provider.dart';

class AcceptableWidget extends StatelessWidget {
  const AcceptableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        return AnimatedCrossFade(
          crossFadeState:
          homeProvider.goingDown ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          firstChild: SizedBox( width: context.width),
          secondChild:  Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xFFFFF9F9)),
                padding:  EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Container(
                  decoration:  BoxDecoration(color: Styles.PRIMARY_COLOR,
                   borderRadius: BorderRadius.circular(8)),
                  padding:  const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  width: context.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text:  TextSpan(
                                    text: "أكثر الرحلات",
                                    style:  AppTextStyles.w600.copyWith(
                                      height: 1.25,
                                        fontSize: 14,
                                        fontFamily: AppStrings.fontFamily,
                                        color: Styles.WHITE_COLOR
                                    ),
                                    children:[
                                       TextSpan(
                                          text: ' المتوافقه ',
                                         style:  AppTextStyles.w600.copyWith(
                                             fontSize: 14,
                                             fontFamily: AppStrings.fontFamily,
                                             color: Styles.SECOUND_PRIMARY_COLOR
                                         ),),
                                      TextSpan(
                                        text: 'مع',
                                        style:  AppTextStyles.w600.copyWith(
                                            fontSize: 14,
                                            color: Styles.WHITE_COLOR
                                        ),),
                                    ],
                                  ),
                                ),
                                Text("مشوارك اليوم!",style: AppTextStyles.w600.copyWith(
                                    fontSize: 16,
                                    color: Styles.WHITE_COLOR,
                                ),),
                                Text("بنسبة تزيد عن 60%",style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                    color: Styles.WHITE_COLOR
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      customImageIconSVG(imageName:SvgImages.whiteBlackLogo )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        );
      }
    );
  }
}

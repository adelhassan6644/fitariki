import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../provider/add_offer_provider.dart';

class AddOffer extends StatelessWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 33,
                ),
                const Expanded(child: SizedBox()),
                Text(
                  getTranslated("make_an_offer_to_captain", context),
                  style: AppTextStyles.w600.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  child: SizedBox(
                    width: 33,
                    child: Text(
                      getTranslated("send", context),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: context.width,
              color: ColorResources.LIGHT_GREY_BORDER,
              child: const SizedBox(),
            ),
          ),
          Consumer<AddOfferProvider>(builder: (_, provider, child) {
            return Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: ColorResources.WHITE_COLOR,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 5.0,
                              spreadRadius: -1,
                              offset: const Offset(0, 6))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: Text(
                                getTranslated("start_of_duration", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: ColorResources.PRIMARY_COLOR
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  DateTime.now()
                                      .dateFormat(format: "yyyy MMM d"),
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 1,
                            width: context.width,
                            color: ColorResources.BORDER_COLOR,
                            child: const SizedBox(),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: Text(
                                getTranslated("end_of_duration", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: ColorResources.PRIMARY_COLOR
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  DateTime.now()
                                      .dateFormat(format: "yyyy MMM d"),
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 1,
                            width: context.width,
                            color: ColorResources.BORDER_COLOR,
                            child: const SizedBox(),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: Text(
                                getTranslated("duration", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: ColorResources.PRIMARY_COLOR
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child:Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){},
                                    child:  const Icon(
                                      Icons.add,
                                      color: ColorResources.SECOUND_PRIMARY_COLOR,
                                      size: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.0.w),
                                    child: Container(
                                      width: 28.w,
                                      height: 28.h,
                                      decoration: BoxDecoration(
                                          color: ColorResources.DISABLED,
                                          border: Border.all(
                                              color:Colors.transparent,
                                              width: 0.5.h),
                                          borderRadius:
                                          BorderRadius.circular(4)),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          "5",
                                          textAlign: TextAlign.center,
                                          style:
                                          AppTextStyles.w500.copyWith(
                                            fontSize: 13,
                                            color: ColorResources
                                                .WHITE_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child:  const Icon(
                                      Icons.remove,
                                      color: ColorResources.SECOUND_PRIMARY_COLOR,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 1,
                            width: context.width,
                            color: ColorResources.BORDER_COLOR,
                            child: const SizedBox(),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: Text(
                                getTranslated("price", context),
                                style: AppTextStyles.w400.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: ColorResources.PRIMARY_COLOR
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text("200",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 13,
                                  )),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              getTranslated("sar", context),
                              style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 1,
                            width: context.width,
                            color: ColorResources.BORDER_COLOR,
                            child: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

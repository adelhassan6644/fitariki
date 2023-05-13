import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../components/tab_widget.dart';


class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int userTypeIndex = 0;
  int userGenderIndex = 0;
  List<String> users = ["passenger", "captain"];
  List<String> gender = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        height: 340.h,
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
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => CustomNavigator.pop(),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        getTranslated("cancel", context),
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14, color: ColorResources.PRIMARY_COLOR),
                      ),
                    ),
                  ),
                  Text(
                    getTranslated("filter", context),
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            getTranslated("reset", context),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 14,
                                color: ColorResources.PRIMARY_COLOR),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                height: 1,
                width: context.width,
                color: ColorResources.LIGHT_GREY_BORDER,
                child: const SizedBox(),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("users_type", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                          width: 170.w,
                          decoration: BoxDecoration(
                              color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.all(2.h),
                          child: Row(
                            children: List.generate(
                                users.length,
                                (index) => Expanded(
                                      child: TabWidget(
                                          backGroundColor:
                                              ColorResources.PRIMARY_COLOR,
                                          innerVPadding: 2.h,
                                          title: getTranslated(
                                              users[index], context),
                                          isSelected: index == userTypeIndex,
                                          onTab: () => setState(
                                              () => userTypeIndex = index)),
                                    )),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("gender", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                          width: 170.w,
                          decoration: BoxDecoration(
                              color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.all(2.h),
                          child: Row(
                            children: List.generate(
                                gender.length,
                                (index) => Expanded(
                                      child: TabWidget(
                                          backGroundColor:
                                              ColorResources.PRIMARY_COLOR,
                                          innerVPadding: 2.h,
                                          innerHPadding: 20.w,
                                          title: getTranslated(
                                              gender[index], context),
                                          svgIcon: genderIcons[index],
                                          iconColor: ColorResources.BLUE_COLOR,
                                          iconSize: 11,
                                          isSelected: index == userGenderIndex,
                                          onTab: () => setState(
                                              () => userGenderIndex = index)),
                                    )),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          getTranslated("city", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,size: 15,)
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          getTranslated("residence_district", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,size: 15,)
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          getTranslated("work_place", context),
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,size: 15,)
                    ],),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_address_picker.dart';
import '../../../components/tab_widget.dart';
import '../provider/home_provider.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.h,
      width: context.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        return SafeArea(
          bottom: true,
          top: false,
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
                      onTap: () {
                        homeProvider.getOffers(withFilter: true);
                        CustomNavigator.pop();
                      },
                      child: Text(
                        getTranslated("filter", context),
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: Styles.PRIMARY_COLOR),
                      ),
                    ),

                    // Text(
                    //   getTranslated("filter", context),
                    //   style: AppTextStyles.w600.copyWith(
                    //     fontSize: 14,
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        homeProvider.getOffers(withFilter: false);
                        homeProvider.reset();
                        CustomNavigator.pop();
                      },
                      child: Text(
                        getTranslated("reset", context),
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: Styles.PRIMARY_COLOR),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  height: 1,
                  width: context.width,
                  color: Styles.LIGHT_GREY_BORDER,
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         getTranslated("users_type", context),
                    //         style: AppTextStyles.w400.copyWith(
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //     ),
                    //     // Container(
                    //     //     width: 170.w,
                    //     //     decoration: BoxDecoration(
                    //     //         color: ColorResources.CONTAINER_BACKGROUND_COLOR,
                    //     //         borderRadius: BorderRadius.circular(6)),
                    //     //     padding: EdgeInsets.all(2.h),
                    //     //     child: Row(
                    //     //       children: List.generate(
                    //     //           users.length,
                    //     //           (index) => Expanded(
                    //     //                 child: TabWidget(
                    //     //                     backGroundColor:
                    //     //                         ColorResources.PRIMARY_COLOR,
                    //     //                     innerVPadding: 2.h,
                    //     //                     title: getTranslated(
                    //     //                         users[index], context),
                    //     //                     isSelected: index == userTypeIndex,
                    //     //                     onTab: () => setState(
                    //     //                         () => userTypeIndex = index)),
                    //     //               )),
                    //     //     )),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
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
                                color:
                                    Styles.CONTAINER_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(6)),
                            padding: EdgeInsets.all(2.h),
                            child: Row(
                              children: List.generate(
                                  homeProvider.genders.length,
                                  (index) => Expanded(
                                        child: TabWidget(
                                            backGroundColor:
                                                Styles.PRIMARY_COLOR,
                                            innerVPadding: 2.h,
                                            innerHPadding: 20.w,
                                            title: getTranslated(
                                                homeProvider.genders[index],
                                                context),
                                            svgIcon:
                                                homeProvider.genderIcons[index],
                                            iconColor:
                                                Styles.BLUE_COLOR,
                                            iconSize: 11,
                                            isSelected:
                                                index == homeProvider.gender,
                                            onTab: () => homeProvider
                                                .selectedGender(index)),
                                      )),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      getTranslated("residence_district", context),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomAddressPicker(
                      hint: getTranslated(
                          "select_your_residence_housing_location", context),
                      onPicked: homeProvider.onSelectStartLocation,
                      location: homeProvider.startLocation,
                      decoration: BoxDecoration(
                        color: Styles.WHITE_COLOR,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.0,
                              spreadRadius: -1,
                              offset: const Offset(0, 2))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      getTranslated("work_place", context),
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    ///end of location
                    CustomAddressPicker(
                      hint: getTranslated(
                          "locate_your_work_study_location_on_the_map",
                          context),
                      onPicked: homeProvider.onSelectEndLocation,
                      location: homeProvider.endLocation,
                      decoration: BoxDecoration(
                        color: Styles.WHITE_COLOR,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4.0,
                              spreadRadius: -1,
                              offset: const Offset(0, 2))
                        ],
                      ),
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           getTranslated("city", context),
                    //           style: AppTextStyles.w400.copyWith(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //       const Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 15,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           getTranslated("residence_district", context),
                    //           style: AppTextStyles.w400.copyWith(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //       const Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 15,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           getTranslated("work_place", context),
                    //           style: AppTextStyles.w400.copyWith(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //       const Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 15,
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

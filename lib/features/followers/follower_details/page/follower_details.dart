import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/followers/follower_details/provider/follower_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../app/core/utils/validation.dart';
import '../../../../components/checkbox_list_tile.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_images.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../components/marquee_widget.dart';
import '../../../../components/tab_widget.dart';
import '../../../../main_models/base_model.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';

class FollowerDetails extends StatelessWidget {
  const FollowerDetails({required this.name, Key? key}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            withBorder: true,
            title: name,
            withBack: true,
            actionWidth: 40,
            actionChild: GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: 40,
                child: Text(
                  getTranslated("save", context),
                  textAlign: TextAlign.start,
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 14, color: ColorResources.PRIMARY_COLOR),
                ),
              ),
            ),
          ),
          Consumer<FollowerDetailsProvider>(
            builder: (_, provider, child) {
              return Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomTextFormField(
                    valid: Validations.name,
                    hint: getTranslated("follower_full_name", context),
                    controller: provider.followerFullName,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextFormField(
                          valid: Validations.name,
                          formatter: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          inputType: TextInputType.number,
                          hint: getTranslated("age", context),
                          controller: provider.age,
                        )),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: ColorResources.PRIMARY_COLOR
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(6)),
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                children: List.generate(
                                    provider.genders.length,
                                    (index) => Expanded(
                                          child: TabWidget(
                                              innerVPadding: 6,
                                              innerHPadding: 20,
                                              backGroundColor:
                                                  ColorResources.PRIMARY_COLOR,
                                              title: getTranslated(
                                                  provider.genders[index],
                                                  context),
                                              svgIcon:
                                                  provider.genderIcons[index],
                                              iconColor:
                                                  ColorResources.BLUE_COLOR,
                                              iconSize: 11,
                                              isSelected:
                                                  index == provider.gender,
                                              onTab: () {
                                                provider.selectedGender(index);
                                              }),
                                        )),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                    child: CheckBoxListTile(
                      title: getTranslated(
                          "the_follower_has_the_same_location_as_my_home",
                          context),
                      onChange: provider.onSelect,
                      check: provider.sameHomeLocation,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      CustomNavigator.push(Routes.PICK_LOCATION,
                          arguments: BaseModel(valueChanged: provider.onSelectStartLocation,object: provider.startLocation));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.LIGHT_BORDER_COLOR,
                              width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: MarqueeWidget(
                              child: Text(
                                provider.startLocation?.address ??
                                    getTranslated(
                                        "select_your_residence_housing_location",
                                        context),
                                style: AppTextStyles.w400.copyWith(
                                    color: provider.startLocation?.address ==
                                            null
                                        ? ColorResources.DISABLED
                                        : ColorResources.SECOUND_PRIMARY_COLOR,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          customImageIconSVG(imageName: SvgImages.map)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                    child: CheckBoxListTile(
                      title: getTranslated(
                          "the_follower_has_the_same_location_as_my_final_destination",
                          context),
                      onChange: provider.onSelect1,
                      check: provider.sameDestination,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => CustomNavigator.push(Routes.PICK_LOCATION,
                        arguments: BaseModel(
                            valueChanged: provider.onSelectEndLocation,
                            object: provider.endLocation)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.LIGHT_BORDER_COLOR,
                              width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: MarqueeWidget(
                              child: Text(
                                provider.endLocation?.address ??
                                    getTranslated(
                                        "locate_your_work_study_location_on_the_map",
                                        context),
                                style: AppTextStyles.w400.copyWith(
                                    color: provider.endLocation?.address == null
                                        ? ColorResources.DISABLED
                                        : ColorResources.SECOUND_PRIMARY_COLOR,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          customImageIconSVG(imageName: SvgImages.map)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomButton(
                    onTap: () {},
                    text: getTranslated("delete_the_follower", context),
                    backgroundColor: ColorResources.WHITE_COLOR,
                    withBorderColor: true,
                    textColor: ColorResources.PRIMARY_COLOR,
                  ),
                ],
              ));
            },
          )
        ],
      ),
    );
  }
}

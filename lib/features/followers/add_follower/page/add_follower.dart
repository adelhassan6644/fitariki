import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/dimensions.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../app/core/utils/validation.dart';
import '../../../../components/bottom_sheet_app_bar.dart';
import '../../../../components/chekbox_listtile.dart';
import '../../../../components/custom_images.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../components/marquee_widget.dart';
import '../../../../components/tab_widget.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../provider/add_follower_provider.dart';

class AddFollower extends StatelessWidget {
  const AddFollower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        width: context.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          color: Colors.white,
        ),
        child: Consumer<AddFollowerProvider>(
          builder: (_, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetAppBar(
                    action: GestureDetector(
                      onTap: () {
                        provider.reset();
                        CustomNavigator.pop();
                      },
                      child: SizedBox(
                        width: 40,
                        child: Text(
                          getTranslated("cancel", context),
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                              color: ColorResources.PRIMARY_COLOR),
                        ),
                      ),
                    ),
                    title: getTranslated("add_follower", context),
                    textBtn: getTranslated("save", context),
                    onTap: () {
                      print("=====>"+provider.followerModel.toJson().toString());
                    }),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomTextFormField(
                      valid: Validations.name,
                      initialValue: provider.followerModel.fullName,
                      hint: getTranslated("follower_full_name", context),
                      onChanged: (v) {
                        provider.followerModel.copyWith(fullName: v);
                        print("=====>${provider.followerModel.fullName}");
                        // provider.followerFullName = v;
                      },
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
                            initialValue: provider.followerModel.age,
                            hint: getTranslated("age", context),
                            onChanged: (v) {
                              provider.followerModel.copyWith(age: v);
                              // provider.age = v;
                            },
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
                                                backGroundColor: ColorResources
                                                    .PRIMARY_COLOR,
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
                                                  provider
                                                      .selectedGender(index);
                                                  provider.followerModel
                                                      .copyWith(gender: index);
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
                            arguments: provider.onSelectStartLocation);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
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
                                  provider.followerModel.pickLocation
                                          ?.address ??
                                      getTranslated(
                                          "select_your_residence_housing_location",
                                          context),
                                  style: AppTextStyles.w400.copyWith(
                                      color: provider.followerModel.pickLocation
                                                  ?.address ==
                                              null
                                          ? ColorResources.DISABLED
                                          : ColorResources
                                              .SECOUND_PRIMARY_COLOR,
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
                          arguments: provider.onSelectEndLocation),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
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
                                  provider.followerModel.endLocation?.address ??
                                      getTranslated(
                                          "locate_your_work_study_location_on_the_map",
                                          context),
                                  style: AppTextStyles.w400.copyWith(
                                      color:
                                      provider.followerModel.endLocation?.address == null
                                              ? ColorResources.DISABLED
                                              : ColorResources
                                                  .SECOUND_PRIMARY_COLOR,
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
                  ],
                )),
              ],
            );
          },
        ));
  }
}

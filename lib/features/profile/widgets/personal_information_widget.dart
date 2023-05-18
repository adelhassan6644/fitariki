import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_drop_down_button.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/marquee_widget.dart';
import '../../../components/tab_widget.dart';
import '../../../helpers/image_picker_helper.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/profile_provider.dart';

class PersonalInformationWidget extends StatelessWidget {
  const PersonalInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final ProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("your_personal_information", context),
      children: [
        if (provider.role == "driver")
          CustomTextFormField(
            valid: Validations.name,
            controller: provider.firstName,
            hint: getTranslated("full_name", context),
          ),
        if (provider.role != "driver")
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                valid: Validations.name,
                controller: provider.firstName,
                hint: getTranslated("first_name", context),
              )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: CustomTextFormField(
                valid: Validations.name,
                controller: provider.lastName,
                hint: getTranslated("second_name", context),
              )),
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
                child: CustomTextFormField(
              valid: Validations.name,
              formatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              inputType: TextInputType.number,
              controller: provider.age,
              hint: getTranslated("age", context),
            )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_COLOR.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: List.generate(
                        provider.genders.length,
                        (index) => Expanded(
                              child: TabWidget(
                                  innerVPadding: 6,
                                  innerHPadding: 20,
                                  backGroundColor: ColorResources.PRIMARY_COLOR,
                                  title: getTranslated(
                                      provider.genders[index], context),
                                  svgIcon: provider.genderIcons[index],
                                  iconColor: ColorResources.BLUE_COLOR,
                                  iconSize: 11,
                                  isSelected: index == provider.gender,
                                  onTab: () {
                                    provider.selectedGender(index);
                                  }),
                            )),
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        CustomDropDownButton(
          items: const ["مصري", "سعودي", "اماراتي"],
          name: getTranslated("nationality", context),
          onChange: provider.selectedNationality,
          value: provider.nationality,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorResources.SECOUND_PRIMARY_COLOR,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (provider.role == "driver")
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: CustomTextFormField(
                    valid: Validations.name,
                    hint: getTranslated("identity_number", context),
                    controller: provider.identityNumber,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: CustomButtonImagePicker(
                    imageUrl: provider.profileModel?.driver?.identityImage,
                    title: getTranslated("identity_image", context),
                    onTap: () => ImagePickerHelper.showOptionSheet(
                        onGet: provider.onSelectIdentityImage),
                    imageFile: provider.identityImage,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                valid: Validations.mail,
                controller: provider.email,
                hint: getTranslated("email", context),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              // CustomTextFormField(
              //   valid: Validations.phone,
              //   controller: provider.phone,
              //   hint: getTranslated("phone", context),
              // )
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () {
            CustomNavigator.push(Routes.PICK_LOCATION,
                arguments: provider.onSelectStartLocation);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ColorResources.LIGHT_BORDER_COLOR, width: 1),
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
                          color: provider.startLocation?.address == null
                              ? ColorResources.DISABLED
                              : ColorResources.SECOUND_PRIMARY_COLOR,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                customImageIconSVG(imageName: SvgImages.map)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

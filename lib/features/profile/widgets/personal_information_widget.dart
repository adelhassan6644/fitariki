import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_address_picker.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/dynamic_drop_down_button.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../components/tab_widget.dart';
import '../../../helpers/image_picker_helper.dart';
import '../provider/profile_provider.dart';

class PersonalInformationWidget extends StatelessWidget {
  const PersonalInformationWidget(
      {required this.provider, Key? key, required this.fromLogin})
      : super(key: key);
  final ProfileProvider provider;
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ExpansionTileWidget(
        title: getTranslated("your_personal_information", context),
        children: [
          Visibility(
            visible: provider.isDriver,
            child: CustomTextFormField(
              valid: Validations.name,
              controller: provider.firstName,
              hint: getTranslated("full_name", context),
              read: !fromLogin,
            ),
          ),
          Visibility(
            visible: !provider.isDriver,
            child: Row(
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: CustomTextFormField(
              valid: Validations.name,
              controller: provider.nickName,
              hint: getTranslated("nick_name", context),
              read: !fromLogin && provider.isDriver,
            ),
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
                read: !fromLogin && provider.isDriver,
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
                                    backGroundColor:
                                        ColorResources.PRIMARY_COLOR,
                                    title: getTranslated(
                                        provider.genders[index], context),
                                    svgIcon: provider.genderIcons[index],
                                    iconColor: ColorResources.BLUE_COLOR,
                                    iconSize: 11,
                                    isSelected: index == provider.gender,
                                    onTab: () {
                                      if (!fromLogin && provider.isDriver) {
                                        return null;
                                      } else {
                                        provider.selectedGender(index);
                                      }
                                    }),
                              )),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DynamicDropDownButton(
            items: provider.countryList,
            name: provider.nationality?.name ??
                getTranslated("nationality", context),
            onChange: provider.selectedNationality,
            value: provider.nationality,
            isInitial: provider.nationality?.name != null,
            initialValue: provider.nationality?.name,
            enable: (fromLogin && provider.isDriver) || !provider.isDriver,
          ),
          const SizedBox(
            height: 8,
          ),
          Visibility(
            visible: provider.isDriver,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      valid: Validations.name,
                      hint: getTranslated("identity_number", context),
                      controller: provider.identityNumber,
                      read: !fromLogin,
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
                          canEdit: fromLogin,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                // CustomTextFormField(
                //   valid: Validations.phone,
                //   controller: provider.phone,
                //   hint: getTranslated("phone", context),
                // )
                // const SizedBox(
                //   height: 8,
                // ),
              ],
            ),
          ),
          CustomTextFormField(
            valid: Validations.mail,
            controller: provider.email,
            hint: getTranslated("email", context),
            inputType: TextInputType.emailAddress,
            read: !fromLogin && provider.isDriver,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomAddressPicker(
            hint: getTranslated(
                "select_your_residence_housing_location", context),
            onPicked: provider.onSelectStartLocation,
            location: provider.startLocation,
            decoration: BoxDecoration(
                border: Border.all(
                    color: ColorResources.LIGHT_BORDER_COLOR, width: 1),
                borderRadius: BorderRadius.circular(8)),
          )
        ],
      ),
    );
  }
}

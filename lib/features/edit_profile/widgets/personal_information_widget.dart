import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/main_widgets/custom_drop_down_button.dart';
import 'package:fitariki/main_widgets/custom_images.dart';
import 'package:fitariki/main_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/marquee_widget.dart';
import '../../../main_widgets/tab_widget.dart';
import '../provider/edit_profile_provider.dart';

class PersonalInformationWidget extends StatelessWidget {
  const PersonalInformationWidget({required this.provider, Key? key})
      : super(key: key);
  final EditProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        getTranslated("your_personal_information", context),
        style: AppTextStyles.w600.copyWith(fontSize: 14),
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      collapsedIconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      collapsedTextColor: ColorResources.SECOUND_PRIMARY_COLOR,
      initiallyExpanded: true,
      iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      textColor:  ColorResources.SECOUND_PRIMARY_COLOR,
      shape: Border.all(
        color: Colors.transparent,width: 0,
        style: BorderStyle.none
      ),
      collapsedShape: Border.all(
          color: Colors.transparent,width: 0,
          style: BorderStyle.none
      ),
      children: [
        Row(
          children: [
            Expanded(
                child: CustomTextFormField(
              valid: Validations.name,
              initialValue: provider.firstName,
              hint: getTranslated("first_name", context),
              onChanged: (v) {
                provider.firstName = v;
              },
            )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: CustomTextFormField(
              valid: Validations.name,
              initialValue: provider.secondName,
              hint: getTranslated("second_name", context),
              onChanged: (v) {
                provider.secondName = v;
              },
            )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
                child: CustomDropDownButton(
              items: const ["15", "20", "25"],
              name: getTranslated("age", context),
              onChange: provider.selectedAge,
              value: provider.age,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ColorResources.SECOUND_PRIMARY_COLOR,
              ),
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
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color:ColorResources.LIGHT_BORDER_COLOR,width: 1 ),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Expanded(
                  child: MarqueeWidget(
                    child: Text("طريق بدون اسم، مطار الملك خالد الدولـي في مدينة الرياض داخل المملكة العربية السعودية.",style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis
                    ),),
                  ),
                ),
                const SizedBox(width: 15,),
                customImageIconSVG(imageName: SvgImages.map)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

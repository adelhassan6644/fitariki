import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_drop_down_button.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../helpers/image_picker_helper.dart';
import '../provider/profile_provider.dart';

class BankDataWidget extends StatelessWidget {
  const BankDataWidget({required this.provider, Key? key}) : super(key: key);
  final ProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        getTranslated("bank_data", context),
        style: AppTextStyles.w600.copyWith(fontSize: 14),
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: EdgeInsets.only(bottom: 24.h),
      collapsedIconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      collapsedTextColor: ColorResources.SECOUND_PRIMARY_COLOR,
      initiallyExpanded: true,
      iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
      textColor: ColorResources.SECOUND_PRIMARY_COLOR,
      shape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      collapsedShape: Border.all(
          color: Colors.transparent, width: 0, style: BorderStyle.none),
      children: [
        CustomTextFormField(
          valid: Validations.name,
          controller: provider.fullName,
          hint: getTranslated("quadruple_name", context),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomDropDownButton(
          items: provider.banks,
          name: getTranslated("bank_name", context),
          onChange: provider.selectedBank,
          value: provider.bankName,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorResources.SECOUND_PRIMARY_COLOR,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          valid: Validations.phone,
          hint: "SA 00000 0000 0000 0000 0000",
          controller: provider.bankAccount,
          inputType: TextInputType.phone,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomButtonImagePicker(
          imageUrl: provider.profileModel?.driver?.bankInfo?.accountImage,
          title: getTranslated("account_number_image", context),
          onTap: () => ImagePickerHelper.showOptionSheet(
              onGet: provider.onSelectBankAccountImage),
          imageFile: provider.bankAccountImage,
        ),
      ],
    );
  }
}

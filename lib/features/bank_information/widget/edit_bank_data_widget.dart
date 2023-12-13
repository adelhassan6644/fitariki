import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/dynamic_drop_down_button.dart';
import '../../../helpers/image_picker_helper.dart';
import '../../profile/provider/profile_provider.dart';

class EditBankDataWidget extends StatelessWidget {
  const EditBankDataWidget(
      {required this.provider, required this.fromLogin, super.key});
  final ProfileProvider provider;
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getTranslated("quadruple_name", context)),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          valid: Validations.name,
          controller: provider.fullName,
          hint: getTranslated("quadruple_name", context),
          read: !fromLogin,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(getTranslated("bank_name", context)),
        SizedBox(
          height: 8.h,
        ),
        DynamicDropDownButton(
          items: provider.bankList,
          name: provider.bank?.name ?? getTranslated("bank_name", context),
          onChange: provider.selectedBank,
          value: provider.bank,
          isInitial: provider.bank != null,
          initialValue: provider.bank?.name,
          enable: fromLogin,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(getTranslated("iban_num", context)),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          valid: Validations.bankAccount,
          hint: "0000 0000 0000 0000 0000 0000",
          onChanged: (v) {
            provider.focus();
          },
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
            // CardNumberFormatter(),
            LengthLimitingTextInputFormatter(22),
          ],
          sufWidget: Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Text("SA",
                  style: AppTextStyles.w500.copyWith(
                    color: provider.hasData
                        ? Styles.SECOUND_PRIMARY_COLOR
                        : Styles.HINT_COLOR,
                  ))),
          controller: provider.bankAccount,
          inputType: TextInputType.number,
          keyboardAction: TextInputAction.done,
          read: !fromLogin,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(getTranslated("account_number_image", context)),
        SizedBox(
          height: 8.h,
        ),
        CustomButtonImagePicker(
          canEdit: fromLogin,
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

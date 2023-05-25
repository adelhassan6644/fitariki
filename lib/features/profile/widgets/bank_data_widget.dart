import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/features/profile/model/bank_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
     /*   SizedBox(
          width: context.width,
          child: FormBuilderDropdown(
            items: provider.bankList.map((Bank item) {
              return DropdownMenuItem<Bank>(
                value: item,
                child: Text(
                  item.name??"",
                  style: AppTextStyles.w500
                      .copyWith(color: ColorResources.TITLE, fontSize: 13),
                ),
              );
            }).toList(),
            onChanged: provider.selectedBank,
            menuMaxHeight: context.height * 0.4,
            initialValue: provider.bank?.name,
            isDense: true,

            isExpanded: true,
            dropdownColor: ColorResources.FILL_COLOR,
            itemHeight: 50,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: ColorResources.HINT_COLOR,
            ),
            iconSize: 22,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
            decoration: InputDecoration(hintStyle: AppTextStyles.w400.copyWith(color: ColorResources.DISABLED, fontSize: 14),
              hintText:provider.bank?.name?? getTranslated("bank_name", context),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child:null,
              ),
              fillColor: ColorResources.FILL_COLOR,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.LIGHT_BORDER_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.SECOUND_PRIMARY_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.LIGHT_BORDER_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.LIGHT_BORDER_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.FAILED_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.RADIUS_DEFAULT,),
                ),
                borderSide: BorderSide(
                    color: ColorResources.FAILED_COLOR,
                    width: 1 ,
                    style: BorderStyle.solid
                ),),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal:8.w),
              prefixIconConstraints: BoxConstraints(maxHeight: 25.h, ),

              errorStyle: AppTextStyles.w500.copyWith(color: ColorResources.FAILED_COLOR, fontSize: 11),
              labelStyle: AppTextStyles.w400.copyWith(color: ColorResources.DISABLED, fontSize: 14),
            ),
            style: AppTextStyles.w500.copyWith(color: ColorResources.PRIMARY_COLOR, fontSize: 14),
            name: getTranslated("bank_name", context),
            elevation: 1,
          ),
        ),*/
        CustomDropDownButton(
          items:   provider.bankList.map((item) {
            return DropdownMenuItem(
              value: item.name,
              child: Text(
                item.name??"",
                style: AppTextStyles.w500
                    .copyWith(color: ColorResources.TITLE, fontSize: 13),
              ),
            );
          }).toList()
        ,
          name: getTranslated("bank_name", context),
          onChange: provider.selectedBank,
          value: provider.bank?.name,
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

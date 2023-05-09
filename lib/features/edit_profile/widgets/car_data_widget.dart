import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/main_widgets/custom_drop_down_button.dart';
import 'package:fitariki/main_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../helpers/image_picker_helper.dart';
import '../../../main_widgets/custom_image_picker_widget.dart';
import '../../../main_widgets/expansion_tile_widget.dart';
import '../provider/edit_profile_provider.dart';

class CarDataWidget extends StatelessWidget {
  const CarDataWidget({required this.provider, Key? key}) : super(key: key);
  final EditProfileProvider provider;
  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("car_data", context),
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                valid: Validations.name,
                initialValue: provider.carName,
                hint: getTranslated("name", context),
                onChanged: (v) {
                  provider.carName = v;
                },
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: CustomDropDownButton(
                items: provider.models,
                name: getTranslated("model", context),
                onChange: provider.selectedModel,
                value: provider.carModel,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                valid: Validations.name,
                initialValue: provider.carPlate,
                hint: getTranslated("plate", context),
                onChanged: (v) {
                  provider.carPlate = v;
                },
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child:  CustomButtonImagePicker(
                title:  getTranslated("car_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(onGet: provider.onSelectCarImage),
                imageFile: provider.carImage,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
              child:  CustomDropDownButton(
                items: provider.capacities,
                name: getTranslated("capacity", context),
                onChange: provider.selectedCapacity,
                value: provider.carCapacity,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child:  CustomButtonImagePicker(
                title:  getTranslated("licence_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(onGet: provider.onSelectLicenceImage),
                imageFile: provider.licenceImage,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
              child:  CustomButtonImagePicker(
                title:  getTranslated("form_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(onGet: provider.onSelectFormImage),
                imageFile: provider.formImage,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child:  CustomButtonImagePicker(
                title:  getTranslated("insurance_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(onGet: provider.onSelectInsuranceImage),
                imageFile: provider.insuranceImage,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

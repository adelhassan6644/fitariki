import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:flutter/material.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_drop_down_button.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../helpers/image_picker_helper.dart';
import '../provider/profile_provider.dart';

class CarDataWidget extends StatelessWidget {
  const CarDataWidget(
      {required this.provider, Key? key, required this.fromLogin})
      : super(key: key);
  final ProfileProvider provider;
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileWidget(
      title: getTranslated("car_data", context),
      children: [
        CustomTextFormField(
          valid: Validations.name,
          controller: provider.carName,
          hint: getTranslated("name", context),
          read: !fromLogin,
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
              child:
              CustomDropDownButton(
                items: provider.models,
                name: getTranslated("model", context),
                onChange: provider.selectedModel,
                value: provider.carModel,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                ),
                enable: fromLogin,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: CustomTextFormField(
                valid: Validations.name,
                controller: provider.carColor,
                hint: getTranslated("color", context),
                read: !fromLogin,
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
                hint: getTranslated("plate", context),
                controller: provider.carPlate,
                read: !fromLogin,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: CustomButtonImagePicker(
                canEdit: fromLogin,
                imageUrl: provider.profileModel?.driver?.carInfo?.carImage,
                title: getTranslated("car_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(
                    onGet: provider.onSelectCarImage),
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
              child: CustomDropDownButton(
                items: provider.seats,
                name: getTranslated("capacity", context),
                onChange: provider.selectedSeat,
                value: provider.carSeats,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                ),
                enable: fromLogin,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: CustomButtonImagePicker(
                canEdit: fromLogin,
                imageUrl: provider.profileModel?.driver?.carInfo?.licenceImage,
                title: getTranslated("licence_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(
                    onGet: provider.onSelectLicenceImage),
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
              child: CustomButtonImagePicker(
                canEdit: fromLogin,
                imageUrl: provider.profileModel?.driver?.carInfo?.formImage,
                title: getTranslated("form_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(
                    onGet: provider.onSelectFormImage),
                imageFile: provider.formImage,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: CustomButtonImagePicker(
                canEdit: fromLogin,
                imageUrl:
                    provider.profileModel?.driver?.carInfo?.insuranceImage,
                title: getTranslated("insurance_image", context),
                onTap: () => ImagePickerHelper.showOptionSheet(
                    onGet: provider.onSelectInsuranceImage),
                imageFile: provider.insuranceImage,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

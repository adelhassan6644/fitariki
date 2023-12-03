import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/images.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/validation.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_drop_down_button.dart';
import '../../../components/custom_image_picker_widget.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../helpers/cupertino_pop_up_helper.dart';
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
        ///Car Name
        CustomTextFormField(
          valid: Validations.name,
          controller: provider.carName,
          hint: getTranslated("name", context),
          read: !fromLogin,
        ),

        ///Car Image && Licence Image
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
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
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: CustomButtonImagePicker(
                  canEdit: fromLogin,
                  imageUrl:
                      provider.profileModel?.driver?.carInfo?.licenceImage,
                  title: getTranslated("licence_image", context),
                  onTap: () => ImagePickerHelper.showOptionSheet(
                      onGet: provider.onSelectLicenceImage),
                  imageFile: provider.licenceImage,
                ),
              ),
            ],
          ),
        ),

        ///Capacity && Model
        Row(
          children: [
            Expanded(
              child: CustomDropDownButton(
                items: provider.seats,
                name: getTranslated("capacity", context),
                onChange: provider.selectedSeat,
                value: provider.carCapacity,
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
              child: CustomDropDownButton(
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
          ],
        ),

        ///Car Plate Number and Letters
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hint: "أ",
                  controller: provider.plateLetterRight,
                  read: !fromLogin,
                  inputType: TextInputType.text,
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hint: "ت",
                  controller: provider.plateLetterMiddle,
                  read: !fromLogin,
                  inputType: TextInputType.text,
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hint: "ع",
                  controller: provider.plateLetterLeft,
                  read: !fromLogin,
                  inputType: TextInputType.text,
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  valid: Validations.plateNumber,
                  hint: "9451",
                  controller: provider.plateNumber,
                  read: !fromLogin,
                  inputType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  maxLength: 4,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () => CupertinoPopUpHelper.showCupertinoPopUp(
                    cancelTextButton: getTranslated("ok", context),
                    image: Images.plateImage,
                    title: getTranslated("car_plate", context),
                    description:
                        getTranslated("car_plate_description", context)),
                child: customImageIconSVG(
                    imageName: SvgImages.hintDialog,
                    height: 20,
                    width: 20,
                    color: Styles.SECOUND_PRIMARY_COLOR),
              ),
            ],
          ),
        ),

        ///Form Image && Sequence Number
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
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      valid: Validations.sequenceNumber,
                      hint: getTranslated("sequence_number", context),
                      maxLength: 9,
                      controller: provider.carSequenceNumber,
                      read: !fromLogin,
                      inputType: TextInputType.number,
                      formatter: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  InkWell(
                    onTap: () => CupertinoPopUpHelper.showCupertinoPopUp(
                        cancelTextButton: getTranslated("ok", context),
                        image: Images.licenceImage,
                        title: getTranslated("sequence_number", context),
                        description: getTranslated(
                            "sequence_number_description", context)),
                    child: customImageIconSVG(
                        imageName: SvgImages.hintDialog,
                        height: 20,
                        width: 20,
                        color: Styles.SECOUND_PRIMARY_COLOR),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),

        ///Insurance Image
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                valid: Validations.name,
                controller: provider.carColor,
                hint: getTranslated("color", context),
                read: !fromLogin,
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

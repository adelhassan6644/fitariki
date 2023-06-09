import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final Widget? sufWidget;
  final Widget? prefixWidget;
  final bool label;
  final TextInputType? inputType;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? sIcon;
  final String? pAssetIcon;
  final String? pSvgIcon;
  final Color? pIconColor;
  final FocusNode? focus;
  final bool? read;
  final VoidCallback? edit;

  final List<TextInputFormatter>? formatter;
  final int? maxLength;
  final Color? fieldColor;
  final int? maxLine;
  final int? minLine;
  final TextInputAction keyboardAction;
  final AutovalidateMode autoValidateMode;
  final TextAlign? textAlign;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    this.keyboardAction = TextInputAction.next,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.prefixWidget,
    this.initialValue,
    this.maxLine = 1,
    this.minLine = 1,
    this.hint,
    this.sufWidget,
    this.onTap,
    this.onChanged,
    this.inputType,
    this.valid,
    this.controller,
    this.focus,
    this.sIcon,
    this.label = false,
    this.read,
    this.edit,
    this.validationMode,
    this.formatter,
    this.maxLength,
    this.pAssetIcon,
    this.pSvgIcon,
    this.pIconColor,
    this.fieldColor,
    this.textAlign,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSaved,
      textAlign: textAlign ?? TextAlign.start,
      autovalidateMode: autoValidateMode,
      textInputAction: keyboardAction,
      onTap: onTap,
      validator: valid,
      controller: controller,
      initialValue: initialValue,
      maxLength: maxLength,
      focusNode: focus,
      readOnly: read == true ? true : false,
      maxLines: maxLine,
      minLines: minLine ?? 1,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.phone
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : formatter,
      style: AppTextStyles.w500
          .copyWith(color: ColorResources.SECOUND_PRIMARY_COLOR, fontSize: 14),
      cursorColor: ColorResources.SECOUND_PRIMARY_COLOR,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: prefixWidget ??
              (pAssetIcon != null
                  ? Image.asset(
                      pAssetIcon!,
                      height: 22.h,
                      color: pIconColor ?? ColorResources.DISABLED,
                    )
                  : pSvgIcon != null
                      ? customImageIconSVG(
                          imageName: pSvgIcon!,
                          color: pIconColor ?? Colors.black,
                          height: 22.h,
                        )
                      : null),
        ),
        focusedBorder: read == true
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.RADIUS_DEFAULT,
                  ),
                ),
                borderSide: BorderSide(
                    color: ColorResources.LIGHT_BORDER_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              )
            : const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.RADIUS_DEFAULT,
                  ),
                ),
                borderSide: BorderSide(
                    color: ColorResources.SECOUND_PRIMARY_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: BorderSide(
              color: ColorResources.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: BorderSide(
              color: ColorResources.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: BorderSide(
              color: ColorResources.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: BorderSide(
              color: ColorResources.FAILED_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: BorderSide(
              color: ColorResources.FAILED_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.h, horizontal: sufWidget != null ? 0 : 8.w),
        isDense: true,
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: AppTextStyles.w400
            .copyWith(color: ColorResources.DISABLED, fontSize: 14),
        labelText: label ? hint : null,
        fillColor: ColorResources.FILL_COLOR,
        floatingLabelStyle: AppTextStyles.w400.copyWith(
            color: ColorResources.SECOUND_PRIMARY_COLOR, fontSize: 11),
        filled: true,
        errorStyle: AppTextStyles.w400
            .copyWith(color: ColorResources.FAILED_COLOR, fontSize: 11),
        prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
      ),
    );
  }
}

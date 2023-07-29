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
  final String? sAssetIcon;
  final String? pAssetIcon;
  final String? pSvgIcon;
  final String? sSvgIcon;
  final Color? pIconColor;
  final Color? sIconColor;
  final FocusNode? focus;
  final bool read;
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
  final BorderRadius? edge;

  const CustomTextFormField({
    super.key,
    this.edge,
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
    this.sAssetIcon,
    this.label = false,
    this.read =false,
    this.edit,
    this.validationMode,
    this.formatter,
    this.maxLength,
    this.pAssetIcon,
    this.pSvgIcon,
    this.sSvgIcon,
    this.sIconColor,
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
      readOnly: read ,
      maxLines: maxLine,
      minLines: minLine ?? 1,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.phone
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : formatter,
      style: AppTextStyles.w500
          .copyWith(color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 14),
      cursorColor: Styles.SECOUND_PRIMARY_COLOR,
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
                      color: pIconColor ?? Styles.DISABLED,
                    )
                  : pSvgIcon != null
                      ? customImageIconSVG(
                          imageName: pSvgIcon!,
                          color: pIconColor ?? Colors.black,
                          height: 22.h,
                        )
                      : null),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: sufWidget ??
              (sAssetIcon != null
                  ? Image.asset(
                sAssetIcon!,
                height: 22.h,
                color: sIconColor ?? Styles.DISABLED,
              )
                  : sSvgIcon != null
                  ? customImageIconSVG(
                imageName: sSvgIcon!,
                color: sIconColor ?? Colors.black,
                height: 22.h,
              )
                  : null),
        ),
        focusedBorder: read == true
            ?  OutlineInputBorder(
                borderRadius: edge??const BorderRadius.all(
                  Radius.circular(
                    Dimensions.RADIUS_DEFAULT,
                  ),
                ),
                borderSide: const BorderSide(
                    color: Styles.LIGHT_BORDER_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              )
            :  OutlineInputBorder(
                borderRadius:edge?? const BorderRadius.all(
                  Radius.circular(
                    Dimensions.RADIUS_DEFAULT,
                  ),
                ),
                borderSide: const BorderSide(
                    color: Styles.SECOUND_PRIMARY_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              ),
        border:  OutlineInputBorder(
          borderRadius: edge?? const BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        disabledBorder:  OutlineInputBorder(
          borderRadius: edge??const BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius:edge?? const BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: edge?? const BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: const BorderSide(
              color: Styles.FAILED_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius:edge?? const BorderRadius.all(
            Radius.circular(
              Dimensions.RADIUS_DEFAULT,
            ),
          ),
          borderSide: const BorderSide(
              color: Styles.FAILED_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.h, horizontal: sufWidget != null ? 0 : 8.w),
        isDense: true,
        alignLabelWithHint: true,
        hintText: hint,
        labelStyle: AppTextStyles.w400.copyWith(color: Styles.DISABLED, fontSize: 14),
        hintStyle: AppTextStyles.w400.copyWith(color: Styles.DISABLED, fontSize: 14),
        labelText: label ? hint : null,
        fillColor: Styles.FILL_COLOR,
        floatingLabelStyle: AppTextStyles.w400.copyWith(color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 11),
        filled: true,
        errorStyle: AppTextStyles.w400.copyWith(color: Styles.FAILED_COLOR, fontSize: 11),
        prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
        suffixIconConstraints: BoxConstraints(maxHeight: 25.h),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final Widget? sufWidget;
  final Widget? prefixWidget;
  final bool label;
  final TextInputType? inputType;
  final Function(String?)? onSave;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final IconData? icon;
  final IconData? eIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? sIcon;
  final String? pAssetIcon;
  final String? pSvgIcon;
  final Color? pIconColor;
  final FocusNode? focus;
  final bool? read;
  final bool? flag;
  final VoidCallback? edit;
  final bool? isEdit;

  final List<TextInputFormatter>? formatter;
  final double? hor;
  final int? maxLength;
  final Color? fieldColor;
  final int? maxLine;
  final int? minLine;
  final bool isValidat;

  const CustomTextFormField({
    super.key,
    this.prefixWidget,
    this.isValidat = true,
    this.maxLine = 1,
    this.minLine = 1,
    this.hint,
    this.sufWidget,
    this.onSave,
    this.onTap,
    this.onChanged,
    this.icon,
    this.inputType,
    this.valid,
    this.controller,
    this.focus,
    this.sIcon,
    this.label = false,
    this.read,
    this.eIcon,
    this.edit,
    this.isEdit,
    this.flag,
    this.hor,
    this.validationMode,
    this.formatter,
    this.maxLength,
    this.pAssetIcon,
    this.pSvgIcon,
    this.pIconColor,
    this.fieldColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      validator: valid,
      controller: controller,
      maxLength: maxLength,
      focusNode: focus,
      readOnly: read == true ? true : false,
      maxLines: maxLine,
      minLines: minLine??1,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.phone ? [
        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
      ] : formatter,
      onSaved: (onSave),
      style: !isValidat ? AppTextStyles.w400.copyWith(color: ColorResources.PRIMARY_COLOR,
          fontSize: 14
      ) : AppTextStyles.w500.copyWith(
          color: ColorResources.SECOUND_PRIMARY_COLOR,
          fontSize: 14
      ),
      cursorColor: ColorResources.SECOUND_PRIMARY_COLOR,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,),
          child: prefixWidget ?? (pAssetIcon != null ? Image.asset(
            pAssetIcon!,
            height: 22.h,
            color: pIconColor??ColorResources.DISABLED,
          ) :pSvgIcon != null?
          customImageIconSVG(
            imageName:pSvgIcon!,
            color:pIconColor?? Colors.black,
            height: 22.h,):null),


        ),
        focusedBorder: read == true ?  const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.RADIUS_DEFAULT,),
          ),
          borderSide: BorderSide(
              color: ColorResources.LIGHT_BORDER_COLOR,
              width: 1 ,
              style: BorderStyle.solid
          ),): const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.RADIUS_DEFAULT,),
          ),
          borderSide: BorderSide(
              color: ColorResources.SECOUND_PRIMARY_COLOR,
              width: 1 ,
              style: BorderStyle.solid
          ),),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.RADIUS_DEFAULT,),
          ),
          borderSide: BorderSide(
              color: ColorResources.LIGHT_BORDER_COLOR,
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
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: sufWidget != null ? 0 : 8.w),
        isDense: true,
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: isValidat ? AppTextStyles.w400.copyWith(
            color: ColorResources.DISABLED,
            fontSize: 14
        ) : AppTextStyles.w400.copyWith(
            color: ColorResources.FAILED_COLOR,
            fontSize: 14
        ),
        labelText: label ? hint : null,
        fillColor: ColorResources.FILL_COLOR,
        floatingLabelStyle: isValidat ? AppTextStyles.w400.copyWith(
            color: ColorResources.SECOUND_PRIMARY_COLOR,
            fontSize: 11
        ) : AppTextStyles.w400.copyWith(
            color: ColorResources.FAILED_COLOR,
            fontSize: 11
        ),
        filled: true,
        errorStyle: AppTextStyles.w400.copyWith(
            color: ColorResources.FAILED_COLOR,
            fontSize: 11
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
      ),
    );
  }
}
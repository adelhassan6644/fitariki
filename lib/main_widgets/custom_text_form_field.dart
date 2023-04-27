import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import 'custom_images.dart';

class CustomTextFormField extends StatefulWidget {
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
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: widget.isValidat ? [] : [const ShakeEffect()],
      child: TextFormField(
        onTap: widget.onTap,
        validator: widget.valid,
        controller: widget.controller,
        maxLength: widget.maxLength,
        focusNode: widget.focus,
        readOnly: widget.read == true ? true : false,
        maxLines: widget.maxLine,
        minLines: widget.minLine??1,
        obscureText: widget.icon == Icons.lock_outline ? _isHidden : false,
        keyboardType: widget.inputType,
        inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
        ] : widget.formatter,
        onSaved: (widget.onSave),
        style: !widget.isValidat ? AppTextStyles.w400.copyWith(color: ColorResources.FAILED_COLOR,
            fontSize: 14
        ) : AppTextStyles.w500.copyWith(
            color: ColorResources.PRIMARY_COLOR,
            fontSize: 14
        ),
        cursorColor: ColorResources.PRIMARY_COLOR,

        onChanged: widget.onChanged,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w,),
            child: widget.prefixWidget ?? (widget.pAssetIcon != null ? Image.asset(
              widget.pAssetIcon!,
              height: 22.h,
              color: widget.pIconColor??ColorResources.DISABLED,
            ) :widget.pSvgIcon != null?
            customImageIconSVG(
                imageName:widget.pSvgIcon!,
                color:widget.pIconColor?? Colors.black,
                height: 22.h,):null),


          ),
          focusedBorder:
          widget.read == true ?  const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.PADDING_SIZE_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.LIGHT_GREY_BORDER,
                  width: 1 ,
                  style: BorderStyle.solid
              )) : const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.PRIMARY_COLOR,
                  width: 0.5,
              )),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
          borderSide: BorderSide(
            color: ColorResources.LIGHT_GREY_BORDER,
            width: 1,
              style: BorderStyle.solid
          )),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.LIGHT_GREY_BORDER,
                  width: 1,
                  style: BorderStyle.solid
              )),
          focusedErrorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5,
                  style: BorderStyle.solid
              )),
          errorBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.FAILED_COLOR,
                  width: 0.5,
                  style: BorderStyle.solid
              )),
          contentPadding: EdgeInsets.symmetric(vertical: 15.w, horizontal: widget.sufWidget != null ? 0 : 15.h),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.RADIUS_DEFAULT,),
              ),
              borderSide: BorderSide(
                  color: ColorResources.LIGHT_GREY_BORDER,
                  width: 1 ,
                style: BorderStyle.solid
              ),),
          isDense: true,
          alignLabelWithHint: true,
          hintText: widget.hint,
          hintStyle: widget.isValidat ? AppTextStyles.w400.copyWith(
              color: ColorResources.HINT_COLOR,
              fontSize: 11
          ) : AppTextStyles.w400.copyWith(
              color: ColorResources.FAILED_COLOR,
              fontSize: 11
          ),
          labelText: widget.label ? widget.hint : null,
          fillColor: ColorResources.FILL_COLOR,
          floatingLabelStyle: widget.isValidat ? AppTextStyles.w400.copyWith(
              color: ColorResources.PRIMARY_COLOR,
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
          labelStyle:  widget.isValidat ? AppTextStyles.w400.copyWith(
              color: ColorResources.HINT_COLOR,
              fontSize: 11
          ) : AppTextStyles.w400.copyWith(
              color: ColorResources.FAILED_COLOR,
              fontSize: 11
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
        ),
      ),
    );
  }
}
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import 'custom_images.dart';

class CustomTextFormField extends StatefulWidget {
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
  final bool read, isPassword;
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
    this.isPassword = false,
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
    this.read = false,
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
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
    return TextFormField(
      onFieldSubmitted: widget.onSaved,
      textAlign: widget.textAlign ?? TextAlign.start,
      autovalidateMode: widget.autoValidateMode,
      textInputAction: widget.keyboardAction,
      onTap: widget.onTap,
      validator: widget.valid,
      controller: widget.controller,
      initialValue: widget.initialValue,
      maxLength: widget.maxLength,
      focusNode: widget.focus,
      readOnly: widget.read,
      obscureText: widget.isPassword == true ? _isHidden : false,
      maxLines: widget.maxLine,
      minLines: widget.minLine ?? 1,
      keyboardType: widget.inputType,
      inputFormatters: widget.inputType == TextInputType.phone
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : widget.formatter,
      style: AppTextStyles.w500
          .copyWith(color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 14),
      cursorColor: Styles.SECOUND_PRIMARY_COLOR,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: widget.prefixWidget ??
              (widget.pAssetIcon != null
                  ? Image.asset(
                      widget.pAssetIcon!,
                      height: 22.h,
                      color: widget.pIconColor ?? Styles.DISABLED,
                    )
                  : widget.pSvgIcon != null
                      ? customImageIconSVG(
                          imageName: widget.pSvgIcon!,
                          color: widget.pIconColor ?? Colors.black,
                          height: 22.h,
                        )
                      : null),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: widget.sufWidget ??
              (widget.sAssetIcon != null
                  ? Image.asset(
                      widget.sAssetIcon!,
                      height: 22.h,
                      color: widget.sIconColor ?? Styles.DISABLED,
                    )
                  : widget.sSvgIcon != null
                      ? customImageIconSVG(
                          imageName: widget.sSvgIcon!,
                          color: widget.sIconColor ?? Colors.black,
                          height: 20.h,
                        )
                      : widget.isPassword == true
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: _visibility,
                              alignment: Alignment.center,
                              icon: _isHidden
                                  ? customImageIconSVG(
                                      imageName: SvgImages.hiddenEyeIcon,
                                      height: 16,
                                      width: 16,
                                      color: Styles.DETAILS_COLOR)
                                  : customImageIconSVG(
                                      imageName: SvgImages.eyeIcon,
                                      height: 16,
                                      width: 16,
                                      color: Styles.PRIMARY_COLOR,
                                    ),
                            )
                          : null),
        ),
        focusedBorder: widget.read == true
            ? OutlineInputBorder(
                borderRadius: widget.edge ??
                    const BorderRadius.all(
                      Radius.circular(
                        Dimensions.RADIUS_DEFAULT,
                      ),
                    ),
                borderSide: const BorderSide(
                    color: Styles.LIGHT_BORDER_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              )
            : OutlineInputBorder(
                borderRadius: widget.edge ??
                    const BorderRadius.all(
                      Radius.circular(
                        Dimensions.RADIUS_DEFAULT,
                      ),
                    ),
                borderSide: const BorderSide(
                    color: Styles.SECOUND_PRIMARY_COLOR,
                    width: 1,
                    style: BorderStyle.solid),
              ),
        border: OutlineInputBorder(
          borderRadius: widget.edge ??
              const BorderRadius.all(
                Radius.circular(
                  Dimensions.RADIUS_DEFAULT,
                ),
              ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: widget.edge ??
              const BorderRadius.all(
                Radius.circular(
                  Dimensions.RADIUS_DEFAULT,
                ),
              ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.edge ??
              const BorderRadius.all(
                Radius.circular(
                  Dimensions.RADIUS_DEFAULT,
                ),
              ),
          borderSide: const BorderSide(
              color: Styles.LIGHT_BORDER_COLOR,
              width: 1,
              style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: widget.edge ??
              const BorderRadius.all(
                Radius.circular(
                  Dimensions.RADIUS_DEFAULT,
                ),
              ),
          borderSide: const BorderSide(
              color: Styles.FAILED_COLOR, width: 1, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: widget.edge ??
              const BorderRadius.all(
                Radius.circular(
                  Dimensions.RADIUS_DEFAULT,
                ),
              ),
          borderSide: const BorderSide(
              color: Styles.FAILED_COLOR, width: 1, style: BorderStyle.solid),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.h, horizontal: widget.sufWidget != null ? 0 : 8.w),
        isDense: true,
        alignLabelWithHint: true,
        hintText: widget.hint,
        labelStyle:
            AppTextStyles.w400.copyWith(color: Styles.DISABLED, fontSize: 14),
        hintStyle:
            AppTextStyles.w400.copyWith(color: Styles.DISABLED, fontSize: 14),
        labelText: widget.label ? widget.hint : null,
        fillColor: Styles.FILL_COLOR,
        floatingLabelStyle: AppTextStyles.w400
            .copyWith(color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 11),
        filled: true,
        errorMaxLines: 2,
        errorStyle: AppTextStyles.w400
            .copyWith(color: Styles.FAILED_COLOR, fontSize: 11),
        prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
        suffixIconConstraints: BoxConstraints(maxHeight: 25.h),
      ),
    );
  }
}

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double? textSize;
  final Color? textColor;
  final Color backgroundColor;
  final String? svgIcon;
  final String? assetIcon;
  final Color? iconColor;
  final double? width;
  final double? height;
  final double? radius;
  final bool isLoading;
  final bool isError;
  final bool withBorderColor;

  const CustomButton(
      {Key? key,
      this.onTap,
        this.radius,
      this.height,
      this.svgIcon,
      this.assetIcon,
      this.isLoading = false,
       this.textColor ,
      this.width,
      this.iconColor ,
        this.textSize,
        this.withBorderColor=false,
      required this.text,
       this.backgroundColor=Styles.PRIMARY_COLOR,  this.isError=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        if(onTap != null && !isLoading){
          onTap!();

        }
      },
      child: AnimatedContainer(
        width: isLoading ? 90.w :width?? context.width,
        height: height??50.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: withBorderColor?Styles.PRIMARY_COLOR: Colors.transparent ),
          borderRadius:  BorderRadius.circular(radius??10),
        ),
        duration: const Duration(
          milliseconds: 600,
        ),
        curve: Curves.easeInOutSine,
        child: Center(
          child: isLoading
              ?  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: withBorderColor?Styles.PRIMARY_COLOR: Styles.WHITE_COLOR,
                  ),
                )
              : Row(
            mainAxisSize: MainAxisSize.min,
                children: [
                  if(assetIcon != null) customImageIcon(
                      imageName: assetIcon!,
                      color: iconColor,
                      width: 24.w,
                      height: 24.w),
                  if(assetIcon != null)SizedBox(width: 8.w,),

                  if(svgIcon != null) customImageIconSVG(
                      imageName: svgIcon!,
                      color: iconColor,
                      width: 18.w,
                      height: 18.w),
                  if(svgIcon != null)SizedBox(width: 8.w,),
                  Expanded(
                    child: Text(text, textAlign: TextAlign.center,style: AppTextStyles.w500.copyWith(
                          fontSize: textSize??16,
                          overflow: TextOverflow.ellipsis,
                          color: textColor??   Styles.WHITE_COLOR,
                        ),),
                  ),
                ],
              ),
        ),
      )
    );
  }
}

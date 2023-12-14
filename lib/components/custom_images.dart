import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget customImageIcon(
    {required String imageName,
    double? width,
    double? height,
    BoxFit fit = BoxFit.fill,
    color}) {
  return Image.asset(
    imageName,
    color: color,
    fit: BoxFit.fill,
    width: width ?? 30,
    height: height ?? 25,
  );
}

Widget customCircleSvgIcon(
    {String? label,
    required String imageName,
    Function? onTap,
    color,
    iconColor,
    double? width,
    double? height,
    double? radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color ?? Styles.PRIMARY_COLOR.withOpacity(0.08),
          radius: radius ?? 24.w,
          child: SvgPicture.asset(
            imageName,
            color: iconColor,
            height: height,
            width: width,
          ),
        ),
        Visibility(
          visible: label != null,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                label ?? "",
                style: AppTextStyles.w400.copyWith(
                    color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customImageIconSVG(
    {required String imageName, Color? color, double? height, double? width}) {
  return SvgPicture.asset(
    imageName,
    color: color,
    height: height,
    width: width,
  );
}

Widget customContainerSVG(
    {required String imageName,
    String? label,
    Color? color,
    double? height,
    double? width}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Styles.LIGHT_GREY_BORDER),
        child: SvgPicture.asset(
          imageName,
          color: color,
          height: height,
          width: width,
        ),
      ),
      Visibility(
        visible: label != null,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            label ?? "",
            style: AppTextStyles.w400
                .copyWith(fontSize: 14, color: Styles.SECOUND_PRIMARY_COLOR),
          ),
        ),
      ),
    ],
  );
}

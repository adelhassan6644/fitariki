import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    required this.title,
    required this.isSelected,
    required this.onTab,
    this.iconSize,
    Key? key,
    this.icon,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  final Function() onTab;
  final String? icon;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? ColorResources.SECOUND_PRIMARY_COLOR : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              customImageIconSVG(
                  imageName: icon ?? "",
                  color: isSelected
                      ? ColorResources.WHITE_COLOR
                      : ColorResources.SECOUND_PRIMARY_COLOR,
                  height: iconSize?.h,
                  width: iconSize?.w),
            if (icon != null) SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected
                      ? ColorResources.WHITE_COLOR
                      : ColorResources.SECOUND_PRIMARY_COLOR,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

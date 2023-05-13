import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../components/custom_images.dart';

class BottomNavBarItem extends StatelessWidget {
final String? imageIcon;
final String? svgIcon;
final VoidCallback onTap;
final bool isSelected;
final String? name;
final double? width;final double? height;

const BottomNavBarItem(
    {super.key, this.imageIcon,this.svgIcon , this.name,this.isSelected = false,
      required this.onTap, this.width=20, this.height=20,});

@override
Widget build(BuildContext context) {
  return InkWell(
    focusColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashColor:Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: onTap,
    child: SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svgIcon != null?
          customImageIconSVG(
            imageName:svgIcon!,
            color:isSelected ? ColorResources.PRIMARY_COLOR :ColorResources.DISABLED ,
            width: width,
          ):
          customImageIcon(
            imageName: imageIcon!,
            height:height,
            color:isSelected ? ColorResources.PRIMARY_COLOR :ColorResources.DISABLED ,
            width: width,
          ),
          name != null?
          Text(name!,style: TextStyle(
            fontWeight:isSelected? FontWeight.w600: FontWeight.w400,
            color: isSelected? ColorResources.PRIMARY_COLOR
                :ColorResources.DISABLED,
            fontSize: 11,
          ),):const SizedBox.shrink()
        ],
      ),
    ),
  );
}
}


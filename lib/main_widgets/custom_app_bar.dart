import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/svg_images.dart';
import '../../navigation/custom_navigation.dart';
import 'custom_images.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? actionChild;
  final bool withCart ;
  final bool withBack ;
  final bool withSearch ;

  const CustomAppBar({Key? key, this.title ,this.withCart = false, this.withSearch =false,this.withBack=false,this.actionChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration:  BoxDecoration(
        border: Border(bottom: BorderSide(
          color: ColorResources.BORDER_COLOR,
          width: 1.h
        )),
      ),padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.toPadding,),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(child: SizedBox()),
              Text(title??"",style: AppTextStyles.w600.copyWith(color: Colors.black,fontSize: 16),),
              const Expanded(child: SizedBox()),
              withBack?  GestureDetector(onTap: (){CustomNavigator.pop();},
                  child: customImageIconSVG(imageName: SvgImages.arrowRightIcon,color: Colors.black)):const SizedBox(width: 24,),
          ],),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),

        ],
      ),
    );
  }

}

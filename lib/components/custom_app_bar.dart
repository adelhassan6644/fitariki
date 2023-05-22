import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/svg_images.dart';
import '../../navigation/custom_navigation.dart';
import 'custom_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withCart;
  final bool withBack;
  final bool withSave;
  final bool withBorder;
  final  double? actionWidth;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.withCart = false,
      this.withSave = false,
      this.withBorder = false,
      this.withBack = true,
        this.actionWidth,
        this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color:ColorResources.APP_BAR_BACKGROUND_COLOR ,
        border:withBorder? Border(
            bottom: BorderSide(color: ColorResources.BORDER_COLOR, width: 1.h)):null,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              withSave
                  ? GestureDetector(
                      onTap: () {
                      },
                      child: customImageIconSVG(
                          imageName: SvgImages.bookMark,
                          color: Colors.black,
                          width: 18))
                  :  actionChild??const SizedBox(
                      width: 18,
                    ),
              const Expanded(child: SizedBox()),
              Text(
                title ?? "",
                style: AppTextStyles.w600
                    .copyWith(color: Colors.black, fontSize: 13),
              ),
              const Expanded(child: SizedBox()),
              withBack
                  ? GestureDetector(
                      onTap: () {
                        CustomNavigator.pop();
                      },
                      child: SizedBox(
                        width: actionWidth?? 18,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ))
                  :  SizedBox(
                      width:actionWidth?? 18,
                    ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(15005,  50);
}

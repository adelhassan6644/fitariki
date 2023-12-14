import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../navigation/custom_navigation.dart';
import '../features/wishlist/widgets/save_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final Widget? actionChild;
  final Widget? sepcailActionChild;
  final bool withCart;
  final bool withBack;
  final int? savedItemId;
  final bool withBorder;
  final bool withBackGround;
  final bool isOffer;
  final double actionWidth;
  final double appBarHeight;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.subTitle,
      this.sepcailActionChild,
      this.withCart = false,
      this.savedItemId,
      this.withBackGround = true,
      this.withBorder = false,
      this.withBack = true,
      this.isOffer = true,
      this.actionWidth = 30,
      this.appBarHeight = 50,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color: withBackGround
            ? Styles.APP_BAR_BACKGROUND_COLOR
            : Colors.transparent,
        border: withBorder
            ? Border(bottom: BorderSide(color: Styles.BORDER_COLOR, width: 1.h))
            : null,
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
              Row(
                children: [
                  savedItemId != null
                      ? SaveButton(
                          id: savedItemId!,
                          isOffer: isOffer,
                        )
                      : actionChild ??
                          const SizedBox(
                            width: 18,
                          ),
                  Visibility(
                    visible: sepcailActionChild != null,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 4,
                        ),
                        sepcailActionChild ?? const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w600
                        .copyWith(color: Colors.black, fontSize: 13),
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: Text(
                      subTitle ?? "",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.w400
                          .copyWith(color: Styles.HINT_COLOR, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              withBack
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            CustomNavigator.pop();
                          },
                          child: SizedBox(
                            width: actionWidth,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: actionWidth,
                    ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(15005, appBarHeight);
}

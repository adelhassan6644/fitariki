import 'package:flutter/material.dart';
import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/main_widgets/custom_images.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFF9F9)),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    customCircleSvgIcon(
                        imageName: SvgImages.location,
                        color: ColorResources.WHITE_COLOR,
                        width: 40,
                        height: 40),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated("current_location", context),
                              style: AppTextStyles.w600.copyWith(fontSize: 13)),
                          Text("طريق بدون اسم، مطار الملك خالد الدولـ...",
                              maxLines: 1,
                              style: AppTextStyles.w400.copyWith(
                                overflow: TextOverflow.ellipsis,
                                  fontSize: 11,
                                  color: ColorResources.HINT_COLOR)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.add,
                size: 24,
              )
            ],
          ),
        ],
      ),
    );
  }
}

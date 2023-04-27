import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15),),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric( vertical: 4),
                child: Container(
                  height: 5.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                      color: const Color(0xFF3C3C43).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(100)),
                  child: const SizedBox(),
                ),
              ),
            ),
            const SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                onTap: ()=>CustomNavigator.pop(),
                child: SizedBox(
                  width: 80,
                  child: Text(getTranslated("cancel", context),style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                    color: ColorResources.PRIMARY_COLOR

                  ),),
                ),
              ),
              Text(getTranslated("filter", context),style: AppTextStyles.w600.copyWith(
                fontSize: 14,

              ),),
              GestureDetector(
                child: SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(getTranslated("reset", context),style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                        color: ColorResources.PRIMARY_COLOR

                      ),),
                    ],
                  ),
                ),
              )
            ],),

          ],
        ),
      ),
    );
  }
}

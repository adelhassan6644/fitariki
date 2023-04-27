import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/text_styles.dart';

class CheckBoxListTile extends StatelessWidget {
  const CheckBoxListTile({
    Key? key,
    this.check = false,
    required this.title,
    this.description,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final String title;
  final String? description;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(!check),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: check
                  ? ColorResources.PRIMARY_COLOR
                  : ColorResources.WHITE_COLOR,
              border: Border.all(
                color: check
                    ? ColorResources.PRIMARY_COLOR
                    : ColorResources.DISABLED,
                width: 1
              )
            ),
            child: check
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  )
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.w400.copyWith(
                  fontSize: 14,
                  color: check
                      ? ColorResources.PRIMARY_COLOR
                      : ColorResources.SUBTITLE),
            ),
          ),
          if(description != null)  Text(
            description!,
            style: AppTextStyles.w400.copyWith(
                fontSize: 14,
                color: check
                    ? ColorResources.PRIMARY_COLOR
                    : ColorResources.SUBTITLE),
          )
        ],
      ),
    );
  }
}

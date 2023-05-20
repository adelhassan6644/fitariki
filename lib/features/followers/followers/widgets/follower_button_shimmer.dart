import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';

class FollowerButtonShimmer extends StatelessWidget {
  const FollowerButtonShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: ColorResources.HINT_COLOR, width: 0.5))),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CustomShimmerContainer(
                  width: 200.w,
                  height: 12.h,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorResources.DISABLED,
                  size: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

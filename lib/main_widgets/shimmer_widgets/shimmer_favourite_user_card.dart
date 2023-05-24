import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../components/shimmer/custom_shimmer.dart';

class ShimmerFavouriteUserCard extends StatelessWidget {
  const ShimmerFavouriteUserCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              const CustomShimmerCircleImage(
                radius: 45,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomShimmerContainer(
                          width: 50.w,
                          height: 12.h,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        CustomShimmerContainer(
                          width: 18.w,
                          height: 18.h,
                        )
                      ],
                    ),
                    CustomShimmerContainer(
                      width: 50.w,
                      height: 12.h,
                    ),
                  ],
                ),
              ),
              CustomShimmerContainer(
                width: 24.w,
                height: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

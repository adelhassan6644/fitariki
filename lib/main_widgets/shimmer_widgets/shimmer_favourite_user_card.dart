import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../components/shimmer/custom_shimmer.dart';
import '../../features/home/widgets/acceptable_analytics_widget.dart';

class ShimmerFavouriteUserCard extends StatelessWidget {
  const ShimmerFavouriteUserCard({
    Key? key,
    this.withSaveButton = true,
  }) : super(key: key);
  final bool withSaveButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(
              vertical: withSaveButton ? 16.h : 0, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  blurRadius: 7.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                children: [
                  const CustomShimmerCircleImage(diameter: 45),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(height: 8),
                        CustomShimmerContainer(
                          width: 50.w,
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: withSaveButton,
                    child: CustomShimmerContainer(
                      width: 24.w,
                      height: 24.h,
                    ),
                  )
                ],
              ),

              ///Matching
              Visibility(
                visible: !withSaveButton,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    AcceptableAnalytics(
                      value: 0,
                      color: Styles.PRIMARY_COLOR,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

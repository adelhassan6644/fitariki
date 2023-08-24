import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../components/marquee_widget.dart';
import '../../components/shimmer/custom_shimmer.dart';
import '../../features/home/widgets/acceptable_analytics_widget.dart';

class ShimmerOfferCard extends StatelessWidget {
  const ShimmerOfferCard({
    this.isSaved = false,
    Key? key,
  }) : super(key: key);
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.2),
                blurRadius: 7.0,
                spreadRadius: -1,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomShimmerCircleImage(
                        diameter: 45,
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
                      if (isSaved == true)
                        CustomShimmerContainer(
                          width: 24.w,
                          height: 24.h,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            CustomShimmerContainer(
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: MarqueeWidget(
                                child: CustomShimmerContainer(
                                  height: 12.h,
                                  width: 35.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                color: Styles.HINT_COLOR,
                                height: 10,
                                width: 1,
                                child: const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: isSaved ? 7 : 5,
                        child: Row(
                          children: [
                            CustomShimmerContainer(
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: MarqueeWidget(
                                child: CustomShimmerContainer(
                                  width: 80.w,
                                  height: 12.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            CustomShimmerContainer(
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: MarqueeWidget(
                                child: CustomShimmerContainer(
                                  width: 35.w,
                                  height: 12.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                color: Styles.HINT_COLOR,
                                height: 10,
                                width: 1,
                                child: const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: isSaved ? 7 : 5,
                        child: Row(
                          children: [
                            CustomShimmerContainer(
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: MarqueeWidget(
                                child: CustomShimmerContainer(
                                  width: 80.w,
                                  height: 12.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (isSaved != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomShimmerContainer(
                    width: 45.w,
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const AcceptableAnalytics(
                    value: 0,
                    color: Styles.PRIMARY_COLOR,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

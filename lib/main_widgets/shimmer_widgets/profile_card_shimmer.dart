import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../components/custom_images.dart';
import '../../components/shimmer/custom_shimmer.dart';

class ProfileCardShimmer extends StatelessWidget {
  const ProfileCardShimmer({this.myProfile = false, Key? key})
      : super(key: key);
  final bool myProfile;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.APP_BAR_BACKGROUND_COLOR,
      child: Column(
        children: [
          Visibility(
              visible: !myProfile,
              child: SizedBox(height: 15.h + context.toPadding)),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 26.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      color: Styles.WHITE_COLOR,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 5.0,
                            spreadRadius: -1,
                            offset: const Offset(0, 6))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomShimmerContainer(
                            width: 50.w,
                            height: 12.h,
                          ),
                          const Expanded(child: SizedBox()),
                          CustomShimmerContainer(
                            width: 50.w,
                            height: 12.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customImageIconSVG(
                                  imageName: SvgImages.delivered),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomShimmerContainer(
                                width: 50.w,
                                height: 12.h,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomShimmerContainer(
                                width: 40.w,
                                height: 12.h,
                              ),
                            ],
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Container(
                            width: 0.5.w,
                            height: 48.h,
                            color: Styles.HINT_COLOR,
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  CustomShimmerContainer(
                                    width: 50.w,
                                    height: 12.h,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  CustomShimmerContainer(
                                    width: 25.w,
                                    height: 12.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomShimmerContainer(
                                width: 70.w,
                                height: 12.h,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomShimmerContainer(
                                width: 50.w,
                                height: 12.h,
                              ),
                            ],
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Container(
                            width: 0.5.w,
                            height: 48.h,
                            color: Styles.HINT_COLOR,
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customImageIconSVG(
                                  imageName: SvgImages.completed),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomShimmerContainer(
                                width: 70.w,
                                height: 12.h,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomShimmerContainer(
                                width: 35.w,
                                height: 12.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h)
                    ],
                  ),
                ),
              ),
              const Center(
                  child: CustomShimmerCircleImage(
                diameter: 65,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

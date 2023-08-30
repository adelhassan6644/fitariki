import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/text_styles.dart';
import 'package:fitariki/components/shimmer/custom_shimmer.dart';
import 'package:fitariki/features/tracking/widget/rider_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../my_rides/widgets/ride_locations_widget.dart';
import '../provider/ride_details_provider.dart';
import '../repo/ride_details_repo.dart';
import 'car_details_widget.dart';

class RideDetailsWidget extends StatelessWidget {
  const RideDetailsWidget({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RideDetailsProvider(repo: sl<RideDetailsRepo>())..getRides(id),
      child: Consumer<RideDetailsProvider>(builder: (_, provider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.5,
                    maxChildSize: 1,
                    expand: false,
                    builder: (_, controller) => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ///Timer
                        Visibility(
                          visible:
                              provider.isDriver && provider.ride?.status == 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: context.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    color: Color(0xFF248A3D),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${Duration(seconds: provider.count).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: provider.count).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                            style: AppTextStyles.w400.copyWith(
                                                color: Styles.WHITE_COLOR),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          customImageIconSVG(
                                              imageName: SvgImages.time,
                                              width: 16,
                                              height: 16),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///Details
                        Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12)),
                                          color: Styles.WHITE_COLOR,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.08),
                                                blurRadius: 5.0,
                                                spreadRadius: -1,
                                                offset: const Offset(0, 6))
                                          ]),
                                      child: SingleChildScrollView(
                                        controller: controller,
                                        child: provider.isLoading
                                            ? const _RideDetailsShimmer()
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16.w,
                                                            5.h,
                                                            16.w,
                                                            16.h),
                                                    child: Center(
                                                      child: Container(
                                                        height: 5,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .RADIUS_DEFAULT),
                                                          color: Styles
                                                              .BORDER_COLOR,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  CarDetailsWidget(
                                                    arriveAt: provider
                                                        .ride!.arrivedAt!,
                                                    pickLocation: provider
                                                        .ride?.pickupLocation,
                                                    carInfo: provider
                                                        .ride?.driver?.carInfo,
                                                    isDriver: provider.isDriver,
                                                    status:
                                                        provider.ride?.status,
                                                  ),
                                                  RiderDetailsWidget(
                                                    image: provider.isDriver
                                                        ? provider.ride?.client
                                                                ?.image ??
                                                            ""
                                                        : provider.ride?.driver
                                                                ?.image ??
                                                            "",
                                                    name: provider.isDriver
                                                        ? provider.ride?.client
                                                                ?.firstName ??
                                                            ""
                                                        : provider.ride?.driver
                                                                ?.firstName ??
                                                            "",
                                                    phone: provider.isDriver
                                                        ? provider.ride?.client
                                                                ?.phone ??
                                                            ""
                                                        : provider.ride?.driver
                                                                ?.phone ??
                                                            "",
                                                    whatsApp: provider.isDriver
                                                        ? provider.ride?.client
                                                                ?.phone ??
                                                            ""
                                                        : provider.ride?.driver
                                                                ?.phone ??
                                                            "",
                                                    onFinish: () => provider
                                                        .changeStatus(id, 3),
                                                    isDriver: provider.isDriver,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_DEFAULT
                                                            .w),
                                                    child: RideLocationsWidget(
                                                      followerAddresses: provider
                                                          .ride!
                                                          .followersLocations!,
                                                      pickLocation: provider
                                                          .ride!.pickupLocation,
                                                      dropOffLocation: provider
                                                          .ride!
                                                          .dropOffLocation,
                                                      status:
                                                          provider.ride!.status,
                                                      isDriver:
                                                          provider.isDriver,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            ///To change Status
            Visibility(
              visible: provider.isDriver &&
                  provider.ride != null &&
                  provider.ride!.status != 3,
              child: Container(
                width: context.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: 24.h),
                color: Styles.WHITE_COLOR,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: CustomButton(
                        text: getTranslated(
                            _buttonText(provider.ride?.status == null
                                ? 0
                                : provider.ride!.status! + 1),
                            context),
                        onTap: () {
                          if (provider.isDriver && provider.ride?.status == 0) {
                            provider.countTime();
                          } else if (provider.isDriver && provider.count != 0) {
                            provider.timer.cancel();
                          }

                          provider.changeStatus(
                              id,
                              provider.ride!.status == null
                                  ? 0
                                  : (provider.ride!.status!.toInt() + 1));
                        },
                        isLoading: provider.isChanging,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _buttonText(status) {
    switch (status) {
      case 0:
        return "go_to_client";
      case 1:
        return "arrive";
      case 2:
        return "start_ride";
      case 3:
        return "end_ride";
      case 4:
        return "";
    }
  }
}

class _RideDetailsShimmer extends StatelessWidget {
  const _RideDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
          child: Center(
            child: Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                color: Styles.BORDER_COLOR,
              ),
            ),
          ),
        ),

        ///Car Details Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: CustomShimmerText(width: context.width * 0.7),
              ),
              SizedBox(height: 24.h),
              CustomShimmerText(width: context.width * 0.5)
            ],
          ),
        ),

        ///Rider Details Shimmer
        Container(
          margin: EdgeInsets.symmetric(vertical: 14.h),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 12.h),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal:
                      BorderSide(color: Styles.LIGHT_GREY_BORDER, width: 1))),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomShimmerCircleImage(
                    diameter: 45,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const CustomShimmerContainer(
                    width: 60,
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              const CustomShimmerCircleImage(
                diameter: 45,
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomShimmerCircleImage(
                    diameter: 45,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const CustomShimmerContainer(
                    width: 60,
                  )
                ],
              ),
            ],
          ),
        ),

        ///Location Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.dotIcon, width: 10, height: 10),
                  const SizedBox(width: 4),
                  const Expanded(child: CustomShimmerText()),
                  const SizedBox(width: 45),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Container(
                  height: 12,
                  width: 2,
                  color: Styles.HINT_COLOR,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customImageIconSVG(
                      imageName: SvgImages.dotIcon, width: 10, height: 10),
                  const SizedBox(width: 4),
                  const Expanded(child: CustomShimmerText()),
                  const SizedBox(width: 45),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

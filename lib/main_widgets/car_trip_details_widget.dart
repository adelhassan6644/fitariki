import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/profile/model/driver_model.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/car_trip_details_shimmer.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';

import '../components/custom_images.dart';
import '../components/expansion_tile_widget.dart';
import '../components/image_pop_up_viewer.dart';

class CarTripDetailsWidget extends StatelessWidget {
  const CarTripDetailsWidget({this.carInfo,this.isLoading = false,this.showCarPlate = false, Key? key}) : super(key: key);
  final CarInfo? carInfo;
  final bool isLoading;
  final bool showCarPlate;

  @override
  Widget build(BuildContext context) {
    return isLoading? const CarTripDetailsShimmer() : Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: ExpansionTileWidget(
        iconColor: Styles.SECOUND_PRIMARY_COLOR,
        title: getTranslated("car_data", context),
        children: [
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.car,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                carInfo?.name ?? "",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: Styles.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.carModel,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                carInfo?.model ?? "",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: Styles.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.seat,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "${carInfo?.seatsCount} ${getTranslated("persons", context)}",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Visibility(
                visible: showCarPlate,
                child: customImageIconSVG(
                    imageName: SvgImages.carPlate,
                    color: Styles.SECOUND_PRIMARY_COLOR,
                    height: 14,
                    width: 14),
              ),
              Visibility(
                visible: showCarPlate,

                child: SizedBox(
                  width: 4.w,
                ),
              ),
              Visibility(
                visible: showCarPlate,
                child: Text(
                  carInfo?.palletNumber ?? "",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 10,
                  ),
                ),
              ),
              Visibility(
                visible: showCarPlate,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 10,
                    width: 1,
                    color: Styles.HINT_COLOR,
                    child: const SizedBox(),
                  ),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.carColor,
                  color: Styles.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                carInfo?.color ?? "",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: Styles.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              InkWell(
                onTap: () => Future.delayed(
                    Duration.zero,
                        () => showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.75),
                        builder: (context) {
                          return ImagePopUpViewer(
                            image: carInfo?.carImage ?? "",
                            isFromInternet:
                            true,
                            title:  getTranslated("car_image", context),
                          );
                        })),
                child: Text(
                  getTranslated("show_car_image", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 10,
                    color: Styles.PRIMARY_COLOR
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

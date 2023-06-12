import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/features/profile/model/driver_model.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';

import '../components/custom_images.dart';
import '../components/expansion_tile_widget.dart';
import '../components/image_pop_up_viewer.dart';
import '../components/image_viewer.dart';

class CarTripDetailsWidget extends StatelessWidget {
  const CarTripDetailsWidget({this.carInfo, Key? key}) : super(key: key);
  final CarInfo? carInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: ExpansionTileWidget(
        iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
        title: getTranslated("car_data", context),
        children: [
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.car,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
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
                  color: ColorResources.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.carModel,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
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
                  color: ColorResources.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.seat,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "${carInfo?.seatsCount} اشخاص",
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
              customImageIconSVG(
                  imageName: SvgImages.carPlate,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                  height: 14,
                  width: 14),
              SizedBox(
                width: 4.w,
              ),
              Text(
                carInfo?.palletNumber ?? "",
                style: AppTextStyles.w400.copyWith(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 10,
                  width: 1,
                  color: ColorResources.HINT_COLOR,
                  child: const SizedBox(),
                ),
              ),
              customImageIconSVG(
                  imageName: SvgImages.carColor,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
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
                  color: ColorResources.HINT_COLOR,
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

                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ImageViewer(
                //       image: carInfo?.carImage ?? "",
                //       isFromInternet: true,
                //     ),
                //   ),
                // ),
                child: Text(
                  getTranslated("show_car_image", context),
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 10,
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

import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../components/expansion_tile_widget.dart';
import '../../../main_widgets/distance_widget.dart';
import '../../../main_widgets/map_widget.dart';
import '../../maps/models/location_model.dart';
import '../../my_offers/widgets/my_offer_card.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({required this.isRequest, Key? key}) : super(key: key);
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            CustomAppBar(
              title: getTranslated("trip", context),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: ColorResources.APP_BAR_BACKGROUND_COLOR,
                    height: 50.h,
                    width: context.width,
                  ),
                  ListAnimator(
                    data: [
                      MyOfferCard(
                        startTime: "6:30:00",
                        endTime: "18:30:00",
                        minPrice: "200",
                        maxPrice: "200",
                        numberOfDays: 20,
                        days: "الأحد، الإثنين، الثلاثاء،الإربعاء",
                        createdAt: Methods.getDayCount(
                          date: DateTime(2023, 5, 11, 12, 30, 30),
                        ).toString(),
                      ),
                      MapWidget(
                        startPoint: LocationModel(
                            longitude: "20",
                            latitude: "20.2",
                            address:
                                "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                        endPoint: LocationModel(
                            longitude: "20.13",
                            latitude: "20.25",
                            address:
                                "Al Munsiyah، طريق الامير محمد بن سلمـ..."),
                      ),
                      DistanceWidget(
                        role: isRequest ? "client" : "driver",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
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
                                  "كامري، تايوتا",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                  "2024",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                  "5 اشخاص",
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
                                  "7653 TNJ",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                  "5 اشخاص",
                                  style: AppTextStyles.w400.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

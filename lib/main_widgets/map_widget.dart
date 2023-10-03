import 'package:fitariki/app/core/utils/app_strings.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/maps/models/location_model.dart';
import 'package:fitariki/main_providers/map_provider.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/map_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLaunch;
import 'package:provider/provider.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/dimensions.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_images.dart';
import '../components/marquee_widget.dart';

class MapWidget extends StatelessWidget {
  const MapWidget(
      {this.startPoint,
      this.endPoint,
      this.stopPoints,
      this.clientName,
      this.launchMap = true,
      this.showAddress = true,
      this.showFullAddress = false,
      this.gender,
      Key? key})
      : super(key: key);
  final LocationModel? startPoint, endPoint;
  final int? stopPoints, gender;
  final String? clientName;
  final bool launchMap;
  final bool showFullAddress;
  final bool showAddress;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider()
        ..setLocation(
          pickup: startPoint ?? AppStrings.defaultPickUp,
          dropOff: endPoint ?? AppStrings.defaultDrop,
        ),
      child: Consumer<MapProvider>(builder: (context, vm, _) {
        if (vm.isLoad) {
          return const MapWidgetShimmer();
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Column(
              children: [
                Visibility(
                  visible: clientName != null && showAddress,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        clientName?.split(" ")[0] ?? "",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                            height: 1.25,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      customImageIconSVG(
                          imageName: gender == 0
                              ? SvgImages.maleIcon
                              : SvgImages.femaleIcon,
                          color: Styles.BLUE_COLOR,
                          width: 11,
                          height: 11)
                    ],
                  ),
                ),

                Visibility(
                  visible: showAddress,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        ///Start Point
                        Expanded(
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              if (launchMap) {
                                bool? isActive =
                                    await mapLaunch.MapLauncher.isMapAvailable(
                                        mapLaunch.MapType.google);
                                bool? isAppleActive =
                                    await mapLaunch.MapLauncher.isMapAvailable(
                                        mapLaunch.MapType.apple);
                                if (isActive!) {
                                  await mapLaunch.MapLauncher.showDirections(
                                    mapType: mapLaunch.MapType.google,
                                    destination: mapLaunch.Coords(
                                      double.parse(startPoint!.latitude!),
                                      double.parse(startPoint!.longitude!),
                                    ),
                                    destinationTitle: startPoint!.address,
                                  );
                                } else if (isAppleActive!) {
                                  await mapLaunch.MapLauncher.showDirections(
                                    // mapType: MapType.apple,
                                    destination: mapLaunch.Coords(
                                      double.parse(startPoint!.latitude!),
                                      double.parse(startPoint!.longitude!),
                                    ),
                                    destinationTitle: startPoint!.address,
                                    mapType: mapLaunch.MapType.apple,
                                  );
                                }
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated("start_point", context),
                                  maxLines: 1,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                MarqueeWidget(
                                  child: Text(
                                    showFullAddress
                                        ? startPoint?.address ?? ""
                                        : startPoint?.address?.split(",")[0] ??
                                            "",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        color: Styles.HINT_COLOR,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),

                        ///Stop points
                        Visibility(
                          visible: stopPoints != null&&stopPoints!=0,
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated("stop_points", context),
                                  maxLines: 1,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                MarqueeWidget(
                                  child: Text(
                                    stopPoints.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        color: Styles.HINT_COLOR,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                            visible: stopPoints != null,
                            child: SizedBox(width: 15.w)),

                        ///Final Destination
                        Expanded(
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              if (launchMap) {
                                bool? isActive =
                                    await mapLaunch.MapLauncher.isMapAvailable(
                                        mapLaunch.MapType.google);
                                bool? isAppleActive =
                                    await mapLaunch.MapLauncher.isMapAvailable(
                                        mapLaunch.MapType.apple);
                                if (isActive!) {
                                  await mapLaunch.MapLauncher.showDirections(
                                    mapType: mapLaunch.MapType.google,
                                    destination: mapLaunch.Coords(
                                      double.parse(endPoint!.latitude!),
                                      double.parse(endPoint!.longitude!),
                                    ),
                                    destinationTitle: endPoint!.address,
                                  );
                                } else if (isAppleActive!) {
                                  await mapLaunch.MapLauncher.showDirections(
                                    // mapType: MapType.apple,
                                    destination: mapLaunch.Coords(
                                      double.parse(endPoint!.latitude!),
                                      double.parse(endPoint!.longitude!),
                                    ),
                                    destinationTitle: endPoint!.address,
                                    mapType: mapLaunch.MapType.apple,
                                  );
                                }
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated("final_destination", context),
                                  maxLines: 1,
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                MarqueeWidget(
                                  child: Text(
                                    showFullAddress
                                        ? endPoint?.address ?? ""
                                        : endPoint?.address?.split(",")[0] ?? "",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.w400.copyWith(
                                        fontSize: 10,
                                        color: Styles.HINT_COLOR,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: context.width,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                      initialCameraPosition: vm.mapCameraPosition,
                      onMapCreated: vm.onMapCreated,
                      padding: vm.googleMapPadding,
                      zoomGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      markers: vm.gMapMarkers,
                      mapToolbarEnabled: false,
                      polylines: vm.gMapPolyLines,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

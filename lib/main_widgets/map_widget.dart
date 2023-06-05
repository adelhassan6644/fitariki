import 'dart:async';
import 'package:fitariki/app/core/utils/app_strings.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/maps/models/location_model.dart';
import 'package:fitariki/main_providers/map_provider.dart';
import 'package:fitariki/main_widgets/shimmer_widgets/map_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart'as mapLunch;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/dimensions.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/custom_images.dart';
import '../components/marquee_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {this.startPoint,
      this.endPoint,
      this.stopPoints,
      this.clientName,
      this.gender,
      Key? key})
      : super(key: key);
  final LocationModel? startPoint, endPoint;
  final int? stopPoints, gender;
  final String? clientName;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<MapProvider>(context, listen: false)
          .setLocation(pickup: widget.startPoint??AppStrings.defaultPickUp, dropOff: widget.endPoint??AppStrings.defaultDrop,);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, vm, _) {
      if(vm.isLoad)
        {
          return  const MapWidgetShimmer();
        }
      else {
        return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            if (widget.clientName != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.clientName!,
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
                      imageName: widget.gender == 0
                          ? SvgImages.maleIcon
                          : SvgImages.femaleIcon,
                      color: ColorResources.BLUE_COLOR,
                      width: 11,
                      height: 11)
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        bool? isActive =await mapLunch.MapLauncher.isMapAvailable(mapLunch.MapType.google);
                        bool? isAppleActive =await mapLunch.MapLauncher.isMapAvailable(mapLunch.MapType.apple);
                        if (isActive!) {
                          await mapLunch. MapLauncher.showDirections(
                            mapType: mapLunch.MapType.google,
                            destination: mapLunch.Coords(
                              double.parse(widget.startPoint!.latitude!) ,
                              double.parse(widget.startPoint!.longitude!) ,
                            ),
                            destinationTitle: widget.startPoint!.address,
                          );
                        } else if (isAppleActive!) {
                          await mapLunch.MapLauncher.showDirections(
                            // mapType: MapType.apple,
                            destination: mapLunch.Coords(
                              double.parse(widget.startPoint!.latitude!) ,
                              double.parse(widget.startPoint!.longitude!) ,
                            ),
                            destinationTitle: widget.startPoint!.address, mapType: mapLunch.MapType.apple,
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated("start_point", context),
                            maxLines: 1,
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                          MarqueeWidget(
                            child: Text(
                              widget.startPoint?.address ??
                                  "Al Munsiyah، طريق الامير محمد بن سلمـ...",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  color: ColorResources.HINT_COLOR,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  if (widget.stopPoints != null)
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated("stop_points", context),
                            maxLines: 1,
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                          MarqueeWidget(
                            child: Text(
                              widget.stopPoints.toString(),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  color: ColorResources.HINT_COLOR,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (widget.stopPoints != null) SizedBox(width: 15.w),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        bool? isActive =await mapLunch.MapLauncher.isMapAvailable(mapLunch.MapType.google);
                        bool? isAppleActive =await mapLunch.MapLauncher.isMapAvailable(mapLunch.MapType.apple);
                        if (isActive!) {
                          await mapLunch. MapLauncher.showDirections(
                            mapType: mapLunch.MapType.google,
                            destination: mapLunch.Coords(
                              double.parse(widget.endPoint!.latitude!) ,
                              double.parse(widget.endPoint!.longitude!) ,
                            ),
                            destinationTitle: widget.endPoint!.address,
                          );
                        } else if (isAppleActive!) {
                          await mapLunch.MapLauncher.showDirections(
                            // mapType: MapType.apple,
                            destination: mapLunch.Coords(
                              double.parse(widget.endPoint!.latitude!) ,
                              double.parse(widget.endPoint!.longitude!) ,
                            ),
                            destinationTitle: widget.endPoint!.address, mapType: mapLunch.MapType.apple,
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getTranslated("final_destination", context),
                            maxLines: 1,
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 10, overflow: TextOverflow.ellipsis),
                          ),
                          MarqueeWidget(
                            child: Text(
                              widget.endPoint?.address ??
                                  "Al Maliyah، طريق الامير محمد بن سلمـ...",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 10,
                                  color: ColorResources.HINT_COLOR,
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
            SizedBox(
              width: context.width,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GoogleMap(
                  initialCameraPosition: vm.mapCameraPosition,
                  onMapCreated: vm.onMapCreated,
                  padding: vm.googleMapPadding,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  markers: vm.gMapMarkers,
                  polylines: vm.gMapPolylines,
                ),
              ),
            ),
          ],
        ),
      );
      }
    });
  }
}

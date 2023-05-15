import 'dart:async';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/maps/models/address_model.dart';
import 'package:fitariki/main_providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/dimensions.dart';
import '../app/core/utils/text_styles.dart';
import '../app/localization/localization/language_constant.dart';
import '../components/marquee_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({this.startPoint, this.endPoint, Key? key}) : super(key: key);
  final LocationModel? startPoint, endPoint;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<MapProvider>(context, listen: false)
          .setLocation(pickup: widget.startPoint!, dropOff: widget.endPoint!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, vm, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 15),
                  Expanded(
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
    });
  }
}

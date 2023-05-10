import 'dart:async';
import 'dart:collection';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/features/maps/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/text_styles.dart';
import '../../app/localization/localization/language_constant.dart';
import '../marquee_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({this.startPoint, this.endPoint, Key? key}) : super(key: key);
  final AddressModel? startPoint, endPoint;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.028734648456997, 31.37266017021682),
    zoom: 14.4746,
  );
  final Set<Polygon> _polygon = HashSet<Polygon>();
  // List<LatLng> points = [
  //   LatLng(do, 72.8776559),
  //   LatLng(28.679079, 77.069710),
  //   LatLng(26.850000, 80.949997),
  //   LatLng(19.0759837, 72.8776559),
  // ];
  // @override
  // void initState() {
  //   //initialize polygon
  //   _polygon.add(
  //       Polygon(
  //         // given polygonId
  //         polygonId: PolygonId('1'),
  //         // initialize the list of points to display polygon
  //         points: points,
  //         // given color to polygon
  //         fillColor: Colors.green.withOpacity(0.3),
  //         // given border color to polygon
  //         strokeColor: Colors.green,
  //         geodesic: true,
  //         // given width of border
  //         strokeWidth: 4,
  //       )
  //   );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
          SizedBox(
            width: context.width,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                zoomControlsEnabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

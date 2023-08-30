import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/features/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/app_strings.dart';
import '../../../components/custom_app_bar.dart';
import '../widget/ride_details_widget.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key, required this.data});
  final Map data;
  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "#_مشوارـ${widget.data["number"]}",
        subTitle: (widget.data["date"] as DateTime).dateFormat(format: "dd MMM, yyyy"),
        appBarHeight: 60,
      ),
      body: Consumer<TrackingProvider>(builder: (context, provider, child) {
        return Center(
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    bearing: 192,
                    target: LatLng(
                      double.parse(AppStrings.defaultLat),
                      double.parse(AppStrings.defaultLong),
                    ),
                    zoom: 14,
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
                  myLocationButtonEnabled: false,
                  trafficEnabled: true,
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                  },
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {},
                ),
                Visibility(
                  visible: provider.isDriver,
                  child: Positioned(
                      top: 10,
                      right: 10,
                      child: customCircleSvgIcon(
                          imageName: SvgImages.sos,
                          width: 45,
                          height: 45,
                          radius: 22.5,
                          color: Colors.transparent,
                          onTap: () async {
                            await launch("tel://911");
                          })),
                ),
                RideDetailsWidget(
                  id: widget.data["id"],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

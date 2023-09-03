import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/features/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../../my_rides/model/my_rides_model.dart';
import '../widget/ride_details_widget.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key, required this.ride});
  final MyRideModel ride;
  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<TrackingProvider>().clearMapData();
      sl<TrackingProvider>().init(rideModel: widget.ride);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "#_مشوارـ${widget.ride.number}",
        subTitle: (widget.ride.day)?.dateFormat(format: "dd MMM, yyyy"),
        appBarHeight: 60,
      ),
      body: Consumer<TrackingProvider>(builder: (context, provider, child) {
        return Center(
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: provider.mapCameraPosition,
                  onMapCreated: provider.onMapCreated,
                  padding: provider.googleMapPadding,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: provider.gMapMarkers,
                  polylines: provider.gMapPolyLines,
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
                  id: widget.ride.id ?? 0,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

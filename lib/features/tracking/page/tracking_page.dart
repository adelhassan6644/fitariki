import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/core/utils/svg_images.dart';
import 'package:fitariki/components/custom_images.dart';
import 'package:fitariki/features/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/address_pointer_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../my_rides/widgets/ride_locations_widget.dart';
import '../widget/car_details_widget.dart';
import '../widget/rider_details_widget.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

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
        title: "#_مشوارـ${4}",
        subTitle: DateTime.now().dateFormat(format: "dd MMM, yyyy"),
        appBarHeight: 60,
      ),
      body: Consumer<TrackingProvider>(builder: (context, provider, child) {
        return Center(
          child: SafeArea(
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
                      child: customCircleSvgIcon(imageName: SvgImages.sos,
                      width: 45,
                      height: 45,
                      radius: 22.5,
                      color: Colors.transparent,
                      onTap: () async {
                        await launch("tel://911");
                      })),
                ),
                Positioned(
                    bottom: -10,
                    width: context.width,
                    child: Container(
                        height: 400.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Styles.WHITE_COLOR,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 5.0,
                                  spreadRadius: -1,
                                  offset: const Offset(0, 6))
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 16.h),
                              child: Center(
                                child: Container(
                                  height: 5,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_DEFAULT),
                                    color: Styles.BORDER_COLOR,
                                  ),
                                ),
                              ),
                            ),
                            const CarDetailsWidget(),
                             RiderDetailsWidget(
                              image: '',
                              name: 'Ahmed',
                              phone: '121254',
                              whatsApp: '123456',
                              isDriver: provider.isDriver,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              child:  RideLocationsWidget(
                                followerAddresses: [],
                                isDriver:provider.isDriver,
                                // pickLocation: ride.pickupLocation,
                                // dropOffLocation: ride.dropOffLocation,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Visibility(
                              visible: !provider.isDriver,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w,
                                    vertical: 24.h),
                                child: CustomButton(
                                  text: getTranslated(_buttonText(1), context),
                                  onTap: _onTapButton(1),
                                ),
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        );
      }),
    );
  }

  _onTapButton(status) {
    switch (status) {
      case 0:
        return () {};
      case 1:
        return () {};
      case 2:
        return () {};
    }
  }

  _buttonText(status) {
    switch (status) {
      case 0:
        return "arrive";
      case 1:
        return "start_ride";
      case 2:
        return "end_ride";
    }
  }
}

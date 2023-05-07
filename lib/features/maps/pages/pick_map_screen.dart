import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../../../main_widgets/custom_button.dart';
import '../models/address_model.dart';
import '../provider/location_provider.dart';
import '../widget/serach_location_widget.dart';

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({
    super.key,
  });

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();

    _initialPosition = LatLng(
      double.parse(AppStrings.defaultLat),
      double.parse(AppStrings.defaultLong),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          withBack: true, title: "تحديد مكان دوامك/دراستك", withBorder: true),
      body: SafeArea(child: Center(child:
          Consumer<LocationProvider>(builder: (c, locationController, _) {
        return Stack(children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 16,
            ),

            minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
            myLocationButtonEnabled: false,

            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;

              locationController.getCurrentLocation(false,
                  mapController: mapController);
            },
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPosition) {
              _cameraPosition = cameraPosition;
            },
            onCameraMoveStarted: () {
              // locationController.disableButton();
            },
            onCameraIdle: () {
              locationController.updatePosition(
                _cameraPosition,
              );
            },
          ),
          Center(
              child: !locationController.isLoading
                  ? const Icon(
                      Icons.location_on_rounded,
                      size: 50,
                      color: ColorResources.PRIMARY_COLOR,
                    )
                  : CupertinoActivityIndicator()),
          ////  prediction section

         /*   Positioned(
            top: Dimensions.PADDING_SIZE_LARGE,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: SearchLocationWidget(
                mapController: _mapController,

                pickedAddress: locationController.pickAddress,
                isEnabled: true),
          ),
*/

          Align(
            alignment: Alignment.bottomCenter,
            // bottom: 30,

            child: !locationController.isLoading
                ? Container(
              height: context.height*.20,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: ColorResources.WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 5.0,
                        spreadRadius: -1,
                        offset: const Offset(0, 6))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1,),
                    Center(
                      child: Container(
                      height: 10,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                            color: ColorResources.BORDER_COLOR,
                            ),),
                    ),
                        Text(
                          'العنوان',
                          style: AppTextStyles.w600
                              .copyWith(color: Colors.black, fontSize: 13),
                        ),
                        Text(
                          locationController.pickAddress,
                          style: AppTextStyles.w400
                              .copyWith(color: Colors.black, fontSize: 13),
                        ),

                        CustomButton(
                            text: "تأكيد الموقع",
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ),
                )
                : Center(child: CupertinoActivityIndicator()),
          ),
       /*   Positioned(
            bottom: 100,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: FloatingActionButton(
                child: Icon(Icons.my_location,
                    color: Theme.of(context).primaryColor),
                mini: true,
                backgroundColor: Theme.of(context).cardColor,
                onPressed: () => locationController.getCurrentLocation(false,
                    mapController: _mapController!)),
          ),*/
        ]);
      }))),
    );
  }
}

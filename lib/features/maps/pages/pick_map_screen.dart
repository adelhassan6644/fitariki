import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../main_widgets/custom_app_bar.dart';
import '../../../main_widgets/custom_button.dart';
import '../models/address_model.dart';
import '../provider/location_provider.dart';

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({required this.valueChanged, Key? key}) : super(key: key);
  final ValueChanged<AddressModel> valueChanged;

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
                  : const CupertinoActivityIndicator()),
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
                ? SafeArea(
                    bottom: true,
                    child: Container(
                      height: 205.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorResources.WHITE_COLOR,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 5.0,
                                spreadRadius: -1,
                                offset: const Offset(0, 6))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Center(
                              child: Container(
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_DEFAULT),
                                  color: ColorResources.BORDER_COLOR,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              getTranslated("address", context),
                              style: AppTextStyles.w600
                                  .copyWith(color: Colors.black, fontSize: 14),
                            ),
                            Text(
                              locationController.pickAddress,
                              maxLines: 2,
                              style: AppTextStyles.w400.copyWith(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                            const Expanded(child: SizedBox()),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: CustomButton(
                                text:
                                    getTranslated("confirm_location", context),
                                onTap: () {
                                  widget.valueChanged(
                                      locationController.addressModel!);
                                  CustomNavigator.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: CupertinoActivityIndicator()),
          ),
        ]);
      }))),
    );
  }
}

import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../main_models/base_model.dart';
import '../provider/location_provider.dart';

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({required this.baseModel, Key? key}) : super(key: key);
  final BaseModel baseModel;

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  @override
  void initState() {

    if (widget.baseModel.object != null) {
      Provider.of<LocationProvider>(context, listen: false).pickAddress =
          widget.baseModel.object.address ?? "";
    } else {
      Provider.of<LocationProvider>(context, listen: false).pickAddress =
          AppStrings.defaultAddress;
    }

    Future.delayed(const Duration(milliseconds: 100), ()=>getInitialPosition());
    super.initState();
  }

  getInitialPosition() {
    if (widget.baseModel.object != null) {
      _initialPosition = LatLng(
          double.parse(
              widget.baseModel.object.latitude ?? AppStrings.defaultLat),
          double.parse(
              widget.baseModel.object.longitude ?? AppStrings.defaultLong));
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: 100),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "تحديد مكان دوامك/دراستك", withBorder: true),
      body: SafeArea(child: Center(child:
          Consumer<LocationProvider>(builder: (c, locationController, _) {
        return Stack(children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              bearing: 192,
              target: LatLng(
                double.parse(AppStrings.defaultLat),
                double.parse(AppStrings.defaultLong),
              ),
              zoom: 50,
            ),
            minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;
              if (widget.baseModel.object == null) {
                locationController.getLocation(false,
                    mapController: _mapController!);
              }
            },
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPosition) {
              _cameraPosition = cameraPosition;
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

          Positioned(
            bottom: -10,
            width: context.width,
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
                                  widget.baseModel.valueChanged!(
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

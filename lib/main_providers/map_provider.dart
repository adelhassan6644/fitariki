import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../app/core/utils/app_strings.dart';
import '../features/maps/models/location_model.dart';

class MapProvider extends ChangeNotifier {
  CameraPosition mapCameraPosition =
      const CameraPosition(target: LatLng(24.280888, 37.987794), zoom: 50);
  GoogleMapController? googleMapController;
  EdgeInsets googleMapPadding = const EdgeInsets.all(10);
  Set<Polyline> gMapPolyLines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  Set<Marker> gMapMarkers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor? destinationIcon = BitmapDescriptor.defaultMarker;
  LocationModel? pickupLocation;
  LocationModel? dropOffLocation;
  bool isLoad = false;
  setLocation(
      {required LocationModel pickup, required LocationModel dropOff}) async {
    isLoad = true;
    notifyListeners();
    polylineCoordinates = [];
    gMapMarkers = {};
    pickupLocation = pickup;
    dropOffLocation = dropOff;
    drawTripPolyLines();
    isLoad = false;

    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();

    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = BitmapDescriptor.defaultMarker;
    //
    destinationIcon = BitmapDescriptor.defaultMarker;
    //
  }

  drawTripPolyLines() async {
    // source pin
    gMapMarkers = {};
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('sourcePin'),
        position: LatLng(double.parse(pickupLocation?.latitude??"0"),
            double.parse(pickupLocation?.longitude??"0")),
        icon: sourceIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    // destination pin
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('destPin'),
        position: LatLng(double.parse(dropOffLocation?.latitude??"0"),
            double.parse(dropOffLocation?.longitude??"0")),
        icon: destinationIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    //load the ploylines
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      AppStrings.googleApiKey,
      PointLatLng(double.parse(pickupLocation?.latitude??"0"),
          double.parse(pickupLocation?.longitude??"0")),
      PointLatLng(double.parse(dropOffLocation?.latitude??"0"),
          double.parse(dropOffLocation?.longitude??"0")),
    );
    //get the points from the result
    List<PointLatLng> result = polylineResult.points;
    //
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // with an id, an RGB color and the list of LatLng pairs

    Polyline polyline = Polyline(
      polylineId: const PolylineId("poly"),
      color: Styles.PRIMARY_COLOR,
      points: polylineCoordinates,
      width: 3,
    );
//
    gMapPolyLines = {};
    gMapPolyLines.add(polyline);

    //
    //zoom to latbound
    final pickupLocationLatLng = LatLng(double.parse(pickupLocation?.latitude??"0"),
        double.parse(pickupLocation?.longitude??"0"));
    final dropoffLocationLatLng = LatLng(
        double.parse(dropOffLocation?.latitude??"0"),
        double.parse(dropOffLocation?.longitude??"0"));

    await updateCameraLocation(
      pickupLocationLatLng,
      dropoffLocationLatLng,
      googleMapController,
    );
    //
    notifyListeners();
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController? mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 40);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
    CameraUpdate cameraUpdate,
    GoogleMapController mapController,
  ) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}

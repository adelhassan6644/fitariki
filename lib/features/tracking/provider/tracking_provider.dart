import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitariki/app/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../my_rides/model/my_rides_model.dart';
import '../repo/tracking_repo.dart';

class TrackingProvider extends ChangeNotifier {
  final TrackingRepo repo;

  TrackingProvider({required this.repo});

  bool get isDriver => repo.isDriver();
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  late StreamSubscription tripUpdateStream;
  late StreamSubscription driverLocationStream;

  LatLng? driverPosition;
  double driverPositionRotation = 0;

  //Map related variables
  CameraPosition mapCameraPosition =
      const CameraPosition(target: LatLng(0.00, 0.00));
  GoogleMapController? googleMapController;
  EdgeInsets googleMapPadding = const EdgeInsets.all(10);
  StreamSubscription? currentLocationListener;

  // this will hold the generated polyLines
  Set<Polyline> gMapPolyLines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  Set<Marker> gMapMarkers = {};
  PolylinePoints polylinePoints = PolylinePoints();
// for my custom icons
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  BitmapDescriptor? driverIcon;

  MyRideModel? ride;

  init({required MyRideModel rideModel}) {
    ride = rideModel;
    Future.delayed(const Duration(milliseconds: 100), () async {
      await drawTripPolyLines();
      startDriverDetailsListener();
    });
    notifyListeners();
  }

  //MAP RELATED FUNCTIONS
  void updateGoogleMapPadding({required double height}) {
    googleMapPadding = EdgeInsets.only(bottom: height - 20);
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();

    //start listening to user current location

    setSourceAndDestinationIcons();
  }

  //
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      Images.pickupLocation,
    );
    //
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      Images.dropoffLocation,
    );
    //
    driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      Images.driverCar,
    );
  }

  //zoom to provided location
  void zoomToLocation(LatLng target, {double zoom = 16}) {
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: target,
            zoom: zoom,
          ),
        ),
      );
      notifyListeners();
    }
  }

  drawTripPolyLines() async {
    // source pin
    gMapMarkers = {};
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('sourcePin'),
        position: LatLng(
            double.parse(
              ride!.pickupLocation!.latitude!,
            ),
            double.parse(
              ride!.pickupLocation!.longitude!,
            )),
        icon: sourceIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    // destination pin
    gMapMarkers.add(
      Marker(
        markerId: const MarkerId('destPin'),
        position: LatLng(
            double.parse(
              ride!.dropOffLocation!.latitude!,
            ),
            double.parse(
              ride!.dropOffLocation!.longitude!,
            )),
        icon: destinationIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    //load the ployLines
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      AppStrings.googleApiKey,
      PointLatLng(
          double.parse(
            ride!.pickupLocation!.latitude!,
          ),
          double.parse(
            ride!.pickupLocation!.longitude!,
          )),
      PointLatLng(
          double.parse(
            ride!.dropOffLocation!.latitude!,
          ),
          double.parse(
            ride!.dropOffLocation!.longitude!,
          )),
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
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
//
    gMapPolyLines = {};
    gMapPolyLines.add(polyline);

    //
    //zoom to latBound
    final pickupLocationLatLng = LatLng(
        double.parse(
          ride!.pickupLocation!.latitude!,
        ),
        double.parse(
          ride!.pickupLocation!.longitude!,
        ));
    final dropoffLocationLatLng = LatLng(
        double.parse(
          ride!.dropOffLocation!.latitude!,
        ),
        double.parse(
          ride!.dropOffLocation!.longitude!,
        ));

    await updateCameraLocation(
      pickupLocationLatLng,
      dropoffLocationLatLng,
      googleMapController!,
    );

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

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

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

  zoomToCurrentLocation() async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    {
      double lat = currentLocation.latitude;
      double lng = currentLocation.longitude;
      zoomToLocation(LatLng(lat, lng));
    }
  }

  bool stopListener() {
    driverLocationStream.cancel();
    return true;
  }

  //Start listening to driver location changes
  void startDriverDetailsListener() async {
    //
    driverLocationStream = firebaseFireStore
        .collection("drivers")
        .doc("${ride!.driver!.id}")
        .snapshots()
        .listen((event) {
      //
      if (!event.exists) {
        return;
      }
      //
      if (event.data()!["lat"] != null) {
        driverPosition = LatLng(event.data()!["lat"], event.data()!["long"]);
        driverPositionRotation = event.data()!["rotation"] ?? 0;
        updateDriverMarkerPosition();
        startZoomFocusDriver();
      }
    });
  }

  updateDriverMarkerPosition() {

    Marker driverMarker = gMapMarkers.firstWhere(
      (e) => e.markerId.value == "driverMarker",
      orElse: () => const Marker(markerId: MarkerId("null")),
    );
    //
    if (driverMarker.markerId.value == "null") {
      driverMarker = Marker(
        markerId: const MarkerId('driverMarker'),
        position: driverPosition!,
        rotation: driverPositionRotation,
        icon: driverIcon!,
        anchor: const Offset(0.5, 0.5),
      );
      gMapMarkers.add(driverMarker);
    } else {
      driverMarker = driverMarker.copyWith(
        positionParam: driverPosition,
        rotationParam: driverPositionRotation,
      );
      gMapMarkers.removeWhere((e) => e.markerId.value == "driverMarker");
      gMapMarkers.add(driverMarker);
    }

    notifyListeners();
  }

  startZoomFocusDriver() {
    //create bond between driver and
    if (driverPosition == null) {
      return;
    }
    log("driverPosition.latitude$driverPosition");
    //zoom to driver and dropoff latBound
    updateCameraLocation(
        driverPosition!,
        LatLng(
          double.parse(ride!.dropOffLocation!.latitude!),
          double.parse(ride!.dropOffLocation!.longitude!),
        ),
        googleMapController);
  }


  clearMapData() {
    gMapMarkers.clear();
    polylineCoordinates.clear();
    gMapPolyLines.clear();

    notifyListeners();
  }
}

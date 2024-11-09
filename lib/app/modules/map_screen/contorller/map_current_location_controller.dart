import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_task/app/core/utils/constants/app_url.dart';
import 'package:map_task/app/core/utils/utility/app_utils.dart';
import 'package:map_task/app/data/models/location_model/location_details_model.dart';
import 'package:map_task/app/dependency/global%20dependency/global_controller.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_polyline_controller.dart';
import 'package:map_task/app/services/network_services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCurrentLocationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _requestLocationPermission();
  }

  Rx<Position?> currentPosition = Rx<Position?>(null);
  late MaplibreMapController mController;
  Rx<String?> address = Rx<String?>(null);
  Rx<Offset?> markerPosition = Rx<Offset?>(null);
  Rx<LatLng?> endPositionLatLng = Rx<LatLng?>(null);
  

  // Define the getter to access _locationDetailsModel
  LocationDetailsModel _locationDetailsModel = LocationDetailsModel();
  LocationDetailsModel get locationDetailsModel => _locationDetailsModel;

  // === Permission Handle For Location === Use This For All Type Permission //
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        await getCurrentLocation();
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }
    } else if (status.isGranted) {
      await getCurrentLocation();
    }
  }

  // === Getting Current Location === //
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Service Disabled, Please enable location services.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print(
            "Permission Denied, Location permissions are permanently denied.");
        openAppSettings();
        return;
      }
    }

    // Getting Current Location of User //
    currentPosition.value = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );

    // Move Camara To User Current Location //
    mController.moveCamera(
      CameraUpdate.newLatLng(
        LatLng(
            currentPosition.value!.latitude, currentPosition.value!.longitude),
      ),
    );

    // Add Maker for User Current Location //
    mController.addSymbol(
      SymbolOptions(
          geometry: LatLng(
            currentPosition.value!.latitude,
            currentPosition.value!.longitude,
          ),
          iconImage: 'assets/current_location_icon.png'),
    );
  }

  // == Set New Symbol On Map When User Tap On Map == //
  Symbol? _currentSymbol;
  void onMapTapped(LatLng latLng) async {
    try {
      if (await Get.find<GlobalController>().checkInternetConnectivity()) {
        // Send request to the reverse geocoding API
        final response = await NetworkCaller().getRequest(
          AppUrl.reverseGeocodingApi(latLng.longitude, latLng.latitude),
        );

        // Check the response status
        if (response.statusCode == 200) {
          _locationDetailsModel =
              LocationDetailsModel.fromJson(response.responseData);

          // Remove the previous marker, if any
          if (_currentSymbol != null) {
            mController.removeSymbol(_currentSymbol!);
            Get.find<MapPolylineController>().clearPolyline();
          }

          // Add a New custom marker to the map
          _currentSymbol = await mController.addSymbol(
            SymbolOptions(
              geometry: latLng,
              iconImage:
                  'assets/new_location_icon.png', // Ensure this asset exists
            ),
          );

          // Update the address observable with the fetched address
          address.value = _locationDetailsModel.place!.address;
          print(" ++++++ ${_locationDetailsModel.place!.country} +++++++");
        } else {
          // Handle error when status code is not 200
          AppUtils.errorToast(message: response.errorMessage);
        }
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print("Error: $e");
      AppUtils.errorToast(
          message: "An error occurred while fetching address information.");
    }
  }
}

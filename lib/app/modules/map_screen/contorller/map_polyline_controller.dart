import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:map_task/app/core/utils/constants/app_url.dart';
import 'package:map_task/app/core/utils/utility/app_utils.dart';
import 'package:map_task/app/data/models/map_polyline_model/map_polyline_model.dart';
import 'package:map_task/app/dependency/global%20dependency/global_controller.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_current_location_controller.dart';
import 'package:map_task/app/services/network_services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapPolylineController extends GetxController {
  // Define the getter to access _locationDetailsModel
  MapPolylineModel _mapPolylineModel = MapPolylineModel();
  MapPolylineModel get mapPolylineModel => _mapPolylineModel;

  // == polyline == //
  Future<void> fetchDirections({
    double? startCoordinateLongitude,
    double? startCoordinateLatitude,
    LatLng? endCoordinate,
  }) async {
    try {
      if (await Get.find<GlobalController>().checkInternetConnectivity()) {
        // Perform the network request
        final response = await NetworkCaller().getRequest(
          AppUrl.routeOverViewApi(startCoordinateLongitude!,
              startCoordinateLatitude!, endCoordinate!),
        );

        if (response.statusCode == 200) {
          // Parse the response data
          _mapPolylineModel = MapPolylineModel.fromJson(response.responseData);

          // Check if response code is "OK"
          if (_mapPolylineModel.code == 'OK') {
            final geometry = _mapPolylineModel.routes?[0].geometry;

            // Draw polyline if geometry exists
            if (geometry != null) {
              drawPolyline(geometry);
            } else {
              AppUtils.errorToast(message: 'Polyline data is missing.');
            }
          } else {
            AppUtils.errorToast(
                message: 'Route not found or invalid response code.');
          }
        } else {
          // Handle unexpected status code
          AppUtils.errorToast(message: response.errorMessage);
        }
      }
    } catch (e) {
      // Catch any exceptions and handle them
      AppUtils.errorToast(message: 'An error occurred: $e');
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encoded);

    // Convert PointLatLng to LatLng
    return result
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }

  void drawPolyline(String encodedPolyline) {
    final points = decodePolyline(encodedPolyline);

    Get.find<MapCurrentLocationController>().mController.addLine(LineOptions(
          geometry: points,
          lineColor: "#FF0000",
          lineWidth: 5.0,
          lineOpacity: 0.6,
        ));
  }

  void clearPolyline() {
    Get.find<MapCurrentLocationController>().mController.clearLines();
  }
}

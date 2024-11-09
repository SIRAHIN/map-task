import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_task/app/core/style/style.dart';
import 'package:map_task/app/core/utils/constants/map_constants.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_current_location_controller.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_polyline_controller.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapScreen extends GetView<MapCurrentLocationController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // == Body Section == //
      body: Stack(
        children: [
          Obx(() {
            return MaplibreMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      controller.currentPosition.value?.latitude ?? 0.0,
                      controller.currentPosition.value?.longitude ?? 0.0),
                  zoom: 15),
              onMapCreated: (MaplibreMapController mapController) {
                controller.mController = mapController;
              },
              onMapClick: (point, coordinates) {
                controller.endPositionLatLng.value = coordinates;
                controller.onMapTapped(coordinates);
              },
              styleString: MapConstants.mapUrl,
            );
          }),

          // Locaiton Info panel Seciton //
          Obx(() {
            if (controller.address.value != null) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.height * .18,
                  width: Get.width * .80,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Place Information',
                        style: headinTextStyle(
                            fontSize: 14,
                            fontColor: Colors.deepOrange,
                            isTextBold: true),
                      ),
                      const Divider(),
                      Expanded(
                        // == AddreddBn Text Section == //
                        child: Text(
                          controller.locationDetailsModel.place?.addressBn ??
                              '-!-',
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          // == CityBn Text Section == //
                          Text(
                            '${controller.locationDetailsModel.place?.cityBn},' ??
                                '-!-',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),

                          // == Country Text Section == //
                          Text(
                            controller.locationDetailsModel.place?.country ??
                                '-!-',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // == Postal Code Text Section == //
                          Text(
                            controller.locationDetailsModel.place?.postCode ??
                                '-!-',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),

                          // == Locaiton Button == //
                          GestureDetector(
                            onTap: () async {
                              await Get.find<MapPolylineController>()
                                  .fetchDirections(
                                      startCoordinateLongitude: controller
                                          .currentPosition.value!.longitude,
                                      startCoordinateLatitude: controller
                                          .currentPosition.value!.latitude,
                                      endCoordinate:
                                          controller.endPositionLatLng.value);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              radius: 15,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }
}

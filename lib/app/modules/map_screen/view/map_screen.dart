import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_task/app/core/style/style.dart';
import 'package:map_task/app/core/utils/constants/map_constants.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_location_controller.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_polyline_controller.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapScreen extends GetView<MapLocationController> {
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
                controller.onMapTap(coordinates);
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
                  height: Get.height * .22,
                  width: Get.width * .85,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Place Information:',
                        style: headinTextStyle(
                            fontSize: 14,
                            fontColor: Colors.deepOrange,
                            isTextBold: true),
                      ),
                      const Divider(),
                      Expanded(
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
                      Expanded(
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // == CityBn Text Section == //
                                Text(
                                  '${controller.locationDetailsModel.place?.cityBn}, ${controller.locationDetailsModel.place?.country}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          controller.locationDetailsModel.place?.postCode ??
                              '-!-',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),

                      // == Coordinate And Button == //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // == Coordinate Code Text Seciton == //
                          Text(
                            '${controller.endPositionLatLng.value?.latitude.toStringAsFixed(4)}° N ${controller.endPositionLatLng.value?.longitude.toStringAsFixed(4)}° E',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          // == Navigation Button Seciton == //
                          SizedBox(
                            height: Get.height * .045,
                            width: Get.width * .30,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    padding:
                                        WidgetStatePropertyAll(EdgeInsets.zero),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.deepPurple)),
                                onPressed: () async {
                                  // Function Calling For Fetching Coordinates //
                                  await Get.find<MapPolylineController>()
                                      .fetchCoordinates(
                                          startCoordinateLongitude: controller
                                              .currentPosition.value!.longitude,
                                          startCoordinateLatitude: controller
                                              .currentPosition.value!.latitude,
                                          endCoordinates: controller
                                              .endPositionLatLng.value);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.directions,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: Get.width * .01,
                                    ),
                                    Text(
                                      'Directions',
                                      style: bodyTextStyle(
                                          fontSize: 12,
                                          fontColor: Colors.white,
                                          isTextBold: true),
                                    ),
                                  ],
                                )),
                          ),
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

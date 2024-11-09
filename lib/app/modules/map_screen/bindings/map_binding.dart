import 'package:get/get.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_current_location_controller.dart';
import 'package:map_task/app/modules/map_screen/contorller/map_polyline_controller.dart';

class MapBinding extends Bindings{
 @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MapCurrentLocationController(), fenix: true);
    Get.lazyPut(() => MapPolylineController(),fenix: true);
  }
}
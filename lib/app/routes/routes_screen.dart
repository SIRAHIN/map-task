import 'package:get/get.dart';
import 'package:map_task/app/modules/map_screen/bindings/map_binding.dart';
import 'package:map_task/app/modules/map_screen/view/map_screen.dart';


import 'routes_name.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: RoutesName.mapScreen,
    page: () => const MapScreen(),
    binding: MapBinding()
  ),

];

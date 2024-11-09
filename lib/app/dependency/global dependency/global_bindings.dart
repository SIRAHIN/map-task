
import 'package:get/get.dart';
import 'package:map_task/app/dependency/global%20dependency/global_controller.dart';


class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController(), permanent: true);
  }
}
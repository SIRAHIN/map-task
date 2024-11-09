import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_task/app/dependency/global%20dependency/global_bindings.dart';

import 'package:map_task/app/modules/map_screen/bindings/map_binding.dart';
import 'package:map_task/app/routes/routes_name.dart';
import 'package:map_task/app/routes/routes_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      getPages: routes,
      initialRoute: RoutesName.mapScreen,
      initialBinding: GlobalBindings(),
    );
  }
}
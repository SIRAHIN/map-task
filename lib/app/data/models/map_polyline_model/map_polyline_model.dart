import 'package:map_task/app/data/models/map_polyline_model/routes_mdoel.dart';
import 'package:map_task/app/data/models/map_polyline_model/way_points_model.dart';

class MapPolylineModel {
  String? code;
  List<Routes>? routes;
  List<Waypoints>? waypoints;

  MapPolylineModel({this.code, this.routes, this.waypoints});

  MapPolylineModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
    if (json['waypoints'] != null) {
      waypoints = <Waypoints>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(new Waypoints.fromJson(v));
      });
    }
  }


}





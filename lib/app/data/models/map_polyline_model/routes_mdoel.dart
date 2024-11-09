import 'package:map_task/app/data/models/map_polyline_model/legs_model.dart';

class Routes {
  String? geometry;
  List<Legs>? legs;
  dynamic distance;
  dynamic duration;
  String? weightName;
  dynamic weight;

  Routes(
      {this.geometry,
      this.legs,
      this.distance,
      this.duration,
      this.weightName,
      this.weight});

  Routes.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
    weightName = json['weight_name'];
    weight = json['weight'];
  }


}
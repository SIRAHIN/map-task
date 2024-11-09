import 'package:map_task/app/data/models/location_model/place_model.dart';

class LocationDetailsModel {
  Place? place;
  int? status;

  LocationDetailsModel({this.place, this.status});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (place != null) {
      data['place'] = place!.toJson();
    }
    data['status'] = status;
    return data;
  }
}





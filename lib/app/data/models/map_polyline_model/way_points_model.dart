class Waypoints {
  String? hint;
  dynamic distance;
  //Null? name;
  List<double>? location;

  Waypoints({this.hint, this.distance, this.location});

  Waypoints.fromJson(Map<String, dynamic> json) {
    hint = json['hint'];
    distance = json['distance'];
    //name = json['name'];
    location = json['location'].cast<double>();
  }

}
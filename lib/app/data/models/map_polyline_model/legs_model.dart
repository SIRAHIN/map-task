
class Legs {
  List<Null>? steps;
  dynamic distance;
  dynamic duration;
  String? summary;
  dynamic weight;

  Legs({this.steps, this.distance, this.duration, this.summary, this.weight});

  Legs.fromJson(Map<String, dynamic> json) {
    // if (json['steps'] != null) {
    //   steps = <Null>[];
    //   json['steps'].forEach((v) {
    //     steps!.add(Null.fromJson(v));
    //   });
    // }
    distance = json['distance'];
    duration = json['duration'];
    summary = json['summary'];
    weight = json['weight'];
  }

 
}
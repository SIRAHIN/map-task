class AddressComponents {
  String? placeName;
  String? house;
  String? road;

  AddressComponents({this.placeName, this.house, this.road});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    placeName = json['place_name'];
    house = json['house'];
    road = json['road'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_name'] = placeName;
    data['house'] = house;
    data['road'] = road;
    return data;
  }
}

class AreaComponents {
  String? area;
  String? subArea;

  AreaComponents({this.area, this.subArea});

  AreaComponents.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    subArea = json['sub_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['sub_area'] = subArea;
    return data;
  }
  }
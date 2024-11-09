import 'package:map_task/app/data/models/location_model/address_components_model.dart';

class Place {
  int? id;
  dynamic distanceWithinMeters;
  String? address;
  String? area;
  String? city;
  String? postCode;
  String? addressBn;
  String? areaBn;
  String? cityBn;
  String? country;
  String? division;
  String? district;
  String? subDistrict;
  String? pauroshova;
  String? union;
  String? locationType;
  AddressComponents? addressComponents;
  AreaComponents? areaComponents;

  Place(
      {this.id,
      this.distanceWithinMeters,
      this.address,
      this.area,
      this.city,
      this.postCode,
      this.addressBn,
      this.areaBn,
      this.cityBn,
      this.country,
      this.division,
      this.district,
      this.subDistrict,
      this.pauroshova,
      this.union,
      this.locationType,
      this.addressComponents,
      this.areaComponents});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distanceWithinMeters = json['distance_within_meters'];
    address = json['address'];
    area = json['area'];
    city = json['city'];
    postCode = json['postCode'];
    addressBn = json['address_bn'];
    areaBn = json['area_bn'];
    cityBn = json['city_bn'];
    country = json['country'];
    division = json['division'];
    district = json['district'];
    subDistrict = json['sub_district'];
    pauroshova = json['pauroshova'];
    union = json['union'];
    locationType = json['location_type'];
    addressComponents = json['address_components'] != null
        ? AddressComponents.fromJson(json['address_components'])
        : null;
    areaComponents = json['area_components'] != null
        ? AreaComponents.fromJson(json['area_components'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['distance_within_meters'] = distanceWithinMeters;
    data['address'] = address;
    data['area'] = area;
    data['city'] = city;
    data['postCode'] = postCode;
    data['address_bn'] = addressBn;
    data['area_bn'] = areaBn;
    data['city_bn'] = cityBn;
    data['country'] = country;
    data['division'] = division;
    data['district'] = district;
    data['sub_district'] = subDistrict;
    data['pauroshova'] = pauroshova;
    data['union'] = union;
    data['location_type'] = locationType;
    if (addressComponents != null) {
      data['address_components'] = addressComponents!.toJson();
    }
    if (areaComponents != null) {
      data['area_components'] = areaComponents!.toJson();
    }
    return data;
  }
}
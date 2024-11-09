import 'package:map_task/app/core/utils/constants/map_constants.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class AppUrl {
  AppUrl._();

  static const String baseUrl = 'https://barikoi.xyz/v2/api';

  static String reverseGeocodingApi(double longitude, double latitude) =>
      '$baseUrl/search/reverse/geocode?api_key=${MapConstants.apiKey}&longitude=$longitude&latitude=$latitude&district=true&post_code=true&country=true&sub_district=true&union=true&pauroshova=true&location_type=true&division=true&address=true&area=true&bangla=true';

  static String routeOverViewApi(double startCoordinateLongitude, double startCoordinateLatitude , LatLng endCordinate) =>
      '$baseUrl/route/$startCoordinateLongitude,$startCoordinateLatitude;${endCordinate.longitude},${endCordinate.latitude}?api_key=${MapConstants.apiKey}&geometries=polyline';
}

import 'package:geocoding/geocoding.dart';

class GeoCoderUtils {
  static Future<String> getAddressByLatLng(double lat, double lng) async {
    var place = (await placemarkFromCoordinates(lat, lng))[0];
    var city = place.locality == "" ? place.subAdministrativeArea : place.locality;
    return "$city,  ${place.administrativeArea} - ${place.country!}";
  }
}

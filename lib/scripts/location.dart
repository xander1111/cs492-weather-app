import 'package:geocoding/geocoding.dart' as geocoding;

class Location {
  final String? city;
  final String? state;
  final String? zip;
  final double lat;
  final double lon;

  Location({
    required this.city,
    required this.state,
    required this.zip,
    required this.lat,
    required this.lon});
}

Future<Location?> getLocationFromAddress(String rawCity, String rawState, String rawZip) async {
  String address = '$rawCity $rawState $rawZip';
  try{ 
    List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
    double lat = locations[0].latitude;
    double lon = locations[0].longitude;
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lon);

    return Location(
      city: placemarks[0].locality,
      state: placemarks[0].administrativeArea,
      zip: placemarks[0].postalCode,
      lat: lat,
      lon: lon,
    );
  } on geocoding.NoResultFoundException {
    return null;
  }
}
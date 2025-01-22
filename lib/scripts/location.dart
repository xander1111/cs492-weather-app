import 'package:geocoding/geocoding.dart' as geocoding;

class Location{
  final String? state;
  final String? city;
  final String? zip;
  final double latitude;
  final double longitude;

  Location({
    required this.state,
    required this.city,
    required this.zip,
    required this.latitude,
    required this.longitude
  });

}

Future<Location?> getLocationFromAddress(String rawCity, String rawState, String rawZip) async {
  // generate an address string from the city, state, zip
  String address = '$rawCity $rawState $rawZip';
  try{ 
    // use geocoding to get the latitude and longitude from the address string
    List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
    double lat = locations[0].latitude;
    double lon = locations[0].longitude;

    // use reverse geocoding to get a placemark from the latitude and longitude
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lon);
    String? state = placemarks[0].administrativeArea;
    String? city = placemarks[0].locality;
    String? zip = placemarks[0].postalCode;

    // return a Location object with the complete location
    return Location(city: city, state: state, zip: zip, latitude: lat, longitude: lon);
  } on geocoding.NoResultFoundException {
    // throws NoResultFoundException when geocoding fails
    return null;
  }
} 
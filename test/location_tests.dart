import 'package:test/test.dart';
import 'package:weatherapp/models/location.dart';

void main(){
  test("Test default constructor", testDefaultConstructor);
  test("Test fromJson()", testFromJson);
  test("Test toJson()", testToJson);
  test("Test equal", testEquality);
  test("Test not equal", testNotEqual);
}

void testDefaultConstructor() {
  Location mockLocation = getMockLocation();

  expect(mockLocation.state, "OR");
  expect(mockLocation.city, "Bend");
  expect(mockLocation.zip, "97702");
  expect(mockLocation.latitude, 44.058174);
  expect(mockLocation.longitude, -121.315308);
}

void testFromJson() {
  Location mockLocation = getMockLocation();
  Map<String, dynamic> testJson = {
    "state": "OR",
    "city": "Bend",
    "zip": "97702",
    "latitude": 44.058174,
    "longitude": -121.315308
  };
  Location locationFromJson = Location.fromJson(testJson);

  expect(locationFromJson.state, mockLocation.state);
  expect(locationFromJson.city, mockLocation.city);
  expect(locationFromJson.zip, mockLocation.zip);
  expect(locationFromJson.latitude, mockLocation.latitude);
  expect(locationFromJson.longitude, mockLocation.longitude);
}

void testToJson() {
  Location mockLocation = getMockLocation();
  Map<String, dynamic> testJson = {
    "state": "OR",
    "city": "Bend",
    "zip": "97702",
    "latitude": 44.058174,
    "longitude": -121.315308,
    "url": null
  };
  Map<String, dynamic> jsonFromLocation = mockLocation.toJson();

  expect(jsonFromLocation, testJson);
}

void testEquality() {
  Location mockLocation1 = getMockLocation();
  Location mockLocation2 = getMockLocation();

  expect(mockLocation1 == mockLocation2, true);
}

void testNotEqual() {
  Location mockLocation1 = getMockLocation();
  Location mockLocation2 = getMockLocation(zip: "12345");

  expect(mockLocation1 == mockLocation2, false);
}


Location getMockLocation({String? zip}) {
  return Location(
    state: "OR",
    city: "Bend",
    zip: zip ?? "97702",
    latitude: 44.058174,
    longitude: -121.315308
  );
}
import 'forecast.dart' as forecast;
import 'location.dart' as location;

// void main() async {
//   testForecast();
// }

void testLocation() async {

  // TODO: Create a list of Map<String, String>
  // Add several (at least 5) city, state, zip Map<String, String> to the list
  // iterate through the list, calling location.getLocationFromAddress function for each iteration
  // passing in the city, state, and zip.
  // Debug with a breakpoint after the return (you can use a placeholder like print("test") for your breakpoint)
  // Check to ensure each location returns as expected through debugging. 

  List<Map<String, String>> cities = [
    {"city" : "Honolulu", "state" : "HI", "zip" : "96817"},
    {"city" : "Santa Ana", "state" : "CA", "zip": "92701"},
    {"city" : "Seattle", "state" : "WA", "zip": "98104"},
    {"city" : "New York", "state" : "NY", "zip": "10002"},
    {"city" : "Boulder", "state" : "CO", "zip": "80309"},
  ];

  for (Map<String, String> city in cities) {
    location.Location? loc = await location.getLocationFromAddress(city["city"]!, city["state"]!, city["zip"]!);
    print("test");
  }

  location.getLocationFromAddress("oijeqofwkjfla", "asdfsd", "98839829382");

}


void testForecast() async {
// testing with Bend, OR coordinates
  // double lat = 44.05;
  // double lon = -121.31;
  List<List<double>> coords = [
    [44.05, -121.31],
    [40.71, -74.006],
    [41.878, -87.629],
    [25.7617, -80.1918],
    [35.0844, -106.65]
  ];

  for (List<double> coord in coords){
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(coord[0], coord[1]);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(coord[0],coord[1]);
  }
}
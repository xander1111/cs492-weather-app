import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  // TODO: Seach for latitutes and longitudes of 5 cities in the US on the internet
  // Create a for loop that will generate forecasts arrays for each city
  // TODO: create forecasts and forecastsHourly both of type List<forecast.Forecast>
  forecast.getForecastFromPoints(lat, lon);
  forecast.getForecastHourlyFromPoints(lat,lon);
}
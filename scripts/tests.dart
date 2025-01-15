import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  //forecast.getForecastFromPoints(44.05, -121.31);
  forecast.getForecastHourlyFromPoints(lat,lon);
}
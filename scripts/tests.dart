import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  // double lat = 44.05;
  // double lon = -121.31;
  List<List<double>> latLongs = [
    [39.29, -76.61],  // Baltimore, MD
    [21.30, -157.85], // Honolulu, HI
    [32.71, -117.16], // San Diego, CA
    [44.97, -93.26],  // Minneapolis, MN
    [61.21, -149.89], // Anchorage, AK
  ];

  for (List<double> city in latLongs) {
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(city[0], city[1]);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(city[0],city[1]);
  }
}
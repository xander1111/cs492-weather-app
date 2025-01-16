import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  List<List<double>> latLongs = [
    [39.29, -76.61],  // Baltimore, MD
    [21.30, -157.85], // Honolulu, HI
    [32.71, -117.16], // San Diego, CA
    [44.97, -93.26],  // Minneapolis, MN
    [61.21, -149.89], // Anchorage, AK
  ];

  for (List<double> city in latLongs) {
    lat = city[0];
    lon = city[1];

    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(lat, lon);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(lat,lon);
  }
}
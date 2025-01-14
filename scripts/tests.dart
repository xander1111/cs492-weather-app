import 'dart:convert' as convert;
import 'dart:ffi';

import 'package:http/http.dart' as http;

void main() async {
  String pointsUrl = "https://api.weather.gov/points/44.058,-121.31";
  Map<String, dynamic> pointsJsonData = await getJsonFromUrl(pointsUrl);


  String forecastUrl = pointsJsonData["properties"]["forecast"];
  String forecastHourlyUrl = pointsJsonData["properties"]["forecastHourly"];

  Map<String, dynamic> forecastJsonData = await getJsonFromUrl(forecastUrl);
  Map<String, dynamic> forecastHourlyJsonData = await getJsonFromUrl(forecastHourlyUrl);

  processForecasts(forecastJsonData["properties"]["periods"]);
  processForecasts(forecastHourlyJsonData["properties"]["periods"]);

  return;
}

Future<Map<String, dynamic>> getJsonFromUrl(String url) async {
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}

void processForecasts(List<dynamic> forecasts){
  for (var forecast in forecasts) {
    processForecast(forecast);
  }
}

void processForecast(Map<String, dynamic> forecast){
  String shortForecast = forecast["shortForecast"];
  int temperature = forecast["temperature"];
  double dewpoint = 0;
  int humidity = 0;
  int precipitation = 0;
  DateTime startTime = DateTime.parse(forecast["startTime"]);  // Looks like this parser converts everything to UTC
  bool isDaytime = forecast["isDaytime"];

  if (forecast["probabilityOfPrecipitation"]["value"] != null) {
    precipitation = forecast["probabilityOfPrecipitation"]["value"];
  }

  if (forecast.containsKey("dewpoint")) {
    dewpoint = forecast["dewpoint"]["value"].toDouble();
  }

  if (forecast.containsKey("relativeHumidity")) {
    humidity = forecast["relativeHumidity"]["value"];
  }

  return;
}
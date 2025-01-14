
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

Future<void> main() async {
  String pointsUrl = "https://api.weather.gov/points/44.05,-121.31";
  processPoints(pointsUrl);

}

void processPoints(String url) async{
  Map<String, dynamic> pointsJson = await getRequestJson(url);

  String forecastUrl = pointsJson["properties"]["forecast"];
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);

  return null;

}


Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}
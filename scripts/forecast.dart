import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;

  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    required this.precipitationProbability,
    required this.humidity,
    required this.dewpoint,
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      name: json["name"].isNotEmpty ? json["name"] : null,
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"],
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
    );
  }

  @override
  String toString() {
    return "name: $name\n"
      "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
      "temperature: $temperature\u00B0 $temperatureUnit\n"
      "windSpeed: $windSpeed\n"
      "windDirection: $windDirection\n"
      "shortForecast: $shortForecast\n"
      "detailedForecast: ${detailedForecast.isNotEmpty ? detailedForecast : "Not available for hourly forecasts"}\n"
      "preciptationProb: ${precipitationProbability ?? "Not available for daily forecasts"}\n"
      "humidity: ${humidity ?? "Not available for daily forecasts"}\n"
      "dewpoint: ${dewpoint ?? "Not available for daily forecasts"}\n";
  }
}

void getForecastFromPoints(double lat, double lon) async{
  // TODO: Update this function to return a list of forecasts
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  processForecasts(forecastJson["properties"]["periods"]);

  return null;
}

void getForecastHourlyFromPoints(double lat, double lon) async{
  // TODO: Update this function to return a list of forecasts
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  processForecasts(forecastHourlyJson["properties"]["periods"]);

  return null;
}

void processForecasts(List<dynamic> forecasts){
  // TODO: Change this function to return a List of Forecast Objects
  for (dynamic forecast in forecasts){
    Forecast forecastObj = Forecast.fromJson(forecast);
  }
}

void processForecast(Map<String, dynamic> forecast){
  String forecastName = forecast["name"];
  bool isDaytime = forecast["isDaytime"];
  int temperature = forecast["temperature"];
  String tempUnit = forecast["temperatureUnit"];
  String windSpeed = forecast["windSpeed"];
  String windDirection = forecast["windDirection"];
  String shortForecast = forecast["shortForecast"];
  String detailedForecast = forecast["detailedForecast"];
  int? preciptationProb = forecast["probabilityOfPrecipitation"]["value"] ?? null;
  int? humidity = forecast["relativeHumidity"] != null ? forecast["relativeHumidity"]["value"] : null;
  num? dewpoint = forecast["dewpoint"]?["value"];

  Forecast forecastObj = Forecast(
    name: forecastName, 
    isDaytime: isDaytime, 
    temperature: temperature, 
    temperatureUnit: tempUnit, 
    windSpeed: windSpeed, 
    windDirection: windDirection, 
    shortForecast: shortForecast, 
    detailedForecast: detailedForecast, 
    precipitationProbability: preciptationProb, 
    humidity: humidity, 
    dewpoint: dewpoint);

  return;
}


Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}
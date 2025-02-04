import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherapp/scripts/time.dart';

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String? detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;
  final DateTime startTime;
  final DateTime endTime;
  final String? tempHighLow;

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
    required this.startTime,
    required this.endTime,
    required this.tempHighLow,
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
      detailedForecast: json["detailedForecast"].isNotEmpty ? json["detailedForecast"]: null ,
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
      startTime: DateTime.parse(json["startTime"]).toLocal(),
      endTime: DateTime.parse(json["endTime"]).toLocal(),
      tempHighLow: null
    );
  }

  @override
  String toString(){
    return "name: ${name ?? "None"}\n"
          "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
          "temperature: $temperature\n"
          "temperatureUnit: $temperatureUnit\n"
          "windSpeed: $windSpeed\n"
          "windDirection: $windDirection\n"
          "shortForecast: $shortForecast\n"
          "detailedForecast: $detailedForecast\n"
          "precipitationProbability: ${precipitationProbability ?? "None"}\n"
          "humidity: ${humidity ?? "None"}\n"
          "dewpoint: ${dewpoint ?? "None"}\n"
          "startTime: ${startTime.toLocal()}\n"
          "endTime: ${endTime.toLocal()}\n"
          "tempHighLow: ${tempHighLow ?? "None"}";
  }

  String getIconPath(){
    String filename = "";
    String forecastLowercase = shortForecast.toLowerCase();

    if (forecastLowercase.contains("sunny")){
      if (forecastLowercase.contains("mostly")) {
        filename = "mostly_sunny";
      }
      else{
        filename = "sunny";
      }
    } 
    else if (forecastLowercase.contains("partly") && forecastLowercase.contains("cloudy")){
      if (!isDaytime) {
        filename = "mostly_cloudy_night";
      }
      else{
        filename = "partly_cloudy";
      }
    }
    else if (forecastLowercase.contains("cloudy")){
      if (!isDaytime && forecastLowercase.contains("mostly")) {
        filename = "mostly_cloudy_night";
      }
      else if (forecastLowercase.contains("mostly")) {
        filename = "mostly_cloudy";
      }
      else{
        filename = "cloudy";
      }
    }
    else if (forecastLowercase.contains("clear")){
      filename = "clear";
    }
    else if (forecastLowercase.contains("dust")){
      filename = "dust";
    }
    else if (forecastLowercase.contains("thunder")){
      if (forecastLowercase.contains("chance")){
        filename = "isolated_tstorms";
      }
      else{
        filename = "storm_tstorms";
      }
    }
    else if (forecastLowercase.contains("freezing")){
      filename = "icy";
    }
    else if (forecastLowercase.contains("fog")){
      filename = "fog";
    }
    else if (forecastLowercase.contains("sleet")){
      filename = "sleet_hail";
    }
    else if (forecastLowercase.contains("rain") && forecastLowercase.contains("snow")){
      filename = "mixed_rain_hail_sleet";
    }
    else if (forecastLowercase.contains("drizzle")){
      filename = "drizzle";
    }
    else if (forecastLowercase.contains("rain")){
      if (forecastLowercase.contains("light")){
        filename = "scattered_showers";
      }
      else if (forecastLowercase.contains("showers")){
        filename = "showers";
      }
      else {
        filename = "showers";
      }
    }
    else if (forecastLowercase.contains("snow")){
      if (forecastLowercase.contains("light")){
        filename = "scattered_snow";
      } 
      else if (forecastLowercase.contains("heavy")){
        filename = "heavy_snow";
      }
      else if (forecastLowercase.contains("showers")){
        filename = "snow_showers";
      }
      else if (forecastLowercase.contains("blowing")){
        filename = "blowing_snow";
      }
      else {
        filename = "snow_showers";
      }
    }
    else {
      return "assets/weather_icons/question.svg";
    }

    return "assets/weather_icons/$filename.svg";
  }
}

Future<List<Forecast>> getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  return processForecasts(forecastJson["properties"]["periods"]);
}

Future<List<Forecast>> getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  return processForecasts(forecastHourlyJson["properties"]["periods"]);
}

List<Forecast> processForecasts(List<dynamic> forecasts){
  List<Forecast> forecastObjs = [];
  for (dynamic forecast in forecasts){
    forecastObjs.add(Forecast.fromJson(forecast));
  }
  return forecastObjs;
}

Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}


Forecast getForecastDaily(Forecast forecast1, Forecast forecast2){
  String tempHighLow = getTempHighLow(forecast1.temperature, forecast2.temperature, forecast1.temperatureUnit);

  return Forecast(
    name: equalDates(DateTime.now(), forecast1.startTime) ? "Today" : forecast1.name, 
    isDaytime: forecast1.isDaytime, 
    temperature: forecast1.temperature, 
    temperatureUnit: forecast1.temperatureUnit, 
    windSpeed: forecast1.windSpeed, 
    windDirection: forecast1.windDirection, 
    shortForecast: forecast1.shortForecast, 
    detailedForecast: forecast1.detailedForecast, 
    precipitationProbability: forecast1.precipitationProbability, 
    humidity: forecast1.humidity, 
    dewpoint: forecast1.dewpoint, 
    startTime: forecast1.startTime, 
    endTime: forecast2.endTime, 
    tempHighLow: tempHighLow);

}

String getTempHighLow(int temp1, int temp2, String tempUnit){
  if (temp1 < temp2){
    return "$temp1°$tempUnit/$temp2°$tempUnit";
  }
  else {
    return "$temp2°$tempUnit/$temp1°$tempUnit";
  }

}
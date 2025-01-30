import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(_forecast.name ?? _forecast.startTime ?? ""),
          Text(_forecast.detailedForecast ?? _forecast.shortForecast),
          Text("Wind: ${_forecast.windSpeed} ${_forecast.windDirection}"),
          Text("Temp: ${_forecast.temperature}${_forecast.temperatureUnit}"),
          Text("Dewpoint: ${_forecast.dewpoint}"),
          Text("Humidity: ${_forecast.humidity}"),
          Text("Chance of Rain: ${_forecast.precipitationProbability}"),
      
        ],
      ),
    );
  }
}

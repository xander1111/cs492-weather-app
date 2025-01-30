import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastSummaryWidget extends StatelessWidget {
  const ForecastSummaryWidget({
    super.key,
    required forecast.Forecast currentForecast
  }) : _forecast = currentForecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    // TODO: update this widget to look better
    // Use flutter documentation to help you
    // Try add spacing and a border around the outside
    // Update the text as well, so the name, forecast, and temperature have different formatting
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 125,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), // Adjust the radius to control the roundness
          border: Border.all(
            color: Colors.blue, // Border color
            width: 2.0, // Border width
          ),
        ),
        padding: EdgeInsets.all(9.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ForecastNameWidget(forecast: _forecast),
                  ShortForecastWidget(forecast: _forecast)
                ],
              ),
            ),
            
            Text("${_forecast.temperature}${_forecast.temperatureUnit}")
          ],
        ),
      ),
    );
  }
}

class ShortForecastWidget extends StatelessWidget {
  const ShortForecastWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Text(
      _forecast.shortForecast,
      textAlign: TextAlign.center,
      style:TextStyle(fontSize: 9.0));
  }
}

class ForecastNameWidget extends StatelessWidget {
  const ForecastNameWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Text(
      _forecast.name ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.0
      ));
  }
}

import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required List<forecast.Forecast> forecasts,
  }) : _forecasts = forecasts;

  final List<forecast.Forecast> _forecasts;

  @override
  Widget build(BuildContext context) {
    return Text(_forecasts.isNotEmpty ? _forecasts[0].shortForecast : "");
  }
}

import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast_summary_widget.dart';

class ForecastSummaries extends StatelessWidget {
  const ForecastSummaries({
    super.key,
    required List<forecast.Forecast> forecasts,
  }) : _forecasts = forecasts;

  final List<forecast.Forecast> _forecasts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: getForecastSummaryWidgets(),
      ),
    );
  }

  List<Widget> getForecastSummaryWidgets() {
    return [
      for (forecast.Forecast forecastObj in _forecasts) Padding(
        padding: const EdgeInsets.all(4.0),
        child: ForecastSummaryWidget(currentForecast: forecastObj),
      ),
    ];
  }
}


import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast_summary_widget.dart';


class ForecastSummariesWidget extends StatelessWidget {
  const ForecastSummariesWidget({
    super.key,
    required List<forecast.Forecast> forecasts,
  }) : _forecasts = forecasts;

  final List<forecast.Forecast> _forecasts;
  
  List<ForecastSummaryWidget> getForecastWidgets(){
    List<ForecastSummaryWidget> widgets = [];

    for (int i = 0; i < _forecasts.length; i++){
      widgets.add(ForecastSummaryWidget(currentForecast: _forecasts[i]));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: getForecastWidgets()));
  }
}

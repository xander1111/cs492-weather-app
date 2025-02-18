
import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/scripts/location.dart' as location;

import 'package:weatherapp/widgets/location_widget.dart';
import 'package:weatherapp/widgets/forecast_summaries_widget.dart';
import 'package:weatherapp/widgets/forecast_widget.dart';

// TODO: Use the new location.database.dart logic to get the locations
// update the addLocations function to only add a single location instead of the entire list of _saved locations
// add delete buttons to the weather widgets
// use those to delete
// you will need to add a delete function to the location_database.dart class


class ForecastTabWidget extends StatelessWidget {
  const ForecastTabWidget({
    super.key,
    required location.Location? activeLocation,
    required forecast.Forecast? activeForecast,
    required List<forecast.Forecast> dailyForecasts,
    required List<forecast.Forecast> filteredForecastsHourly,
    required Function setActiveForecast,
    required Function setActiveHourlyForecast

  }) : _location = activeLocation, 
      _activeForecast = activeForecast,
      _dailyForecasts = dailyForecasts,
      _filteredForecastsHourly = filteredForecastsHourly,
      _setActiveForecast = setActiveForecast,
      _setActiveHourlyForecast = setActiveHourlyForecast;

  final location.Location? _location;
  final forecast.Forecast? _activeForecast;
  final List<forecast.Forecast> _dailyForecasts;
  final List<forecast.Forecast> _filteredForecastsHourly;
  final Function _setActiveForecast;
  final Function _setActiveHourlyForecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
        child: Column(
          children: [
            LocationWidget(location: _location),
            _activeForecast != null ? ForecastWidget(forecast: _activeForecast) : Text(""),
            _dailyForecasts.isNotEmpty ? ForecastSummariesWidget(forecasts: _dailyForecasts, setActiveForecast: _setActiveForecast) : Text(""),
            _filteredForecastsHourly.isNotEmpty ? ForecastSummariesWidget(forecasts: _filteredForecastsHourly, setActiveForecast: _setActiveHourlyForecast) : Text("")
          ],
        ),
      ),
    );
  }
}
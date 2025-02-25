import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    var activeLocation = locationProvider.activeLocation;
    return SizedBox(
        child: Text(
            "${activeLocation?.city ?? "city"}, ${activeLocation?.state ?? "state"} ${activeLocation?.zip ?? "zip"}"));
  }
}

import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location.dart' as location;


// TODO: When the user clicks the Get From Location button:
// Besides setting the active location (which it is already doing)
// Add that location to a saved locations list (you'll need to create this)
// Display the saved locations in a new widget below the get from GPS button
// make the saved location widgets onTap()-able, so the user can tap a previously saved location, 
// setting the location based on that
// 


class LocationTabWidget extends StatefulWidget {
  const LocationTabWidget({
    super.key,
    required Function setLocation,
    required location.Location? activeLocation
  }) : _setLocation = setLocation, _location = activeLocation;

  final Function _setLocation;
  final location.Location? _location;

  @override
  State<LocationTabWidget> createState() => _LocationTabWidgetState();
}

class _LocationTabWidgetState extends State<LocationTabWidget> {

  List<location.Location> _savedLocations = [];

  void _addLocation(location.Location location){
    setState(() {
      _savedLocations.add(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationDisplayWidget(activeLocation: widget._location),
        LoctionInputWidget(setLocation: widget._setLocation), // pass in _addLocation
        ElevatedButton(onPressed: ()=>{widget._setLocation()},child: const Text("Get From GPS")),
        // new widget pass _savedLocations
      ],
    );
  }
}

class LocationDisplayWidget extends StatelessWidget {
  const LocationDisplayWidget({
    super.key,
    required location.Location? activeLocation
  }) : _location = activeLocation;

  final location.Location? _location;

  @override
  Widget build(BuildContext context) {
    return Text(_location != null ? "${_location.city}, ${_location.state} ${_location.zip}" : "No Location Set");
  }
}

class LoctionInputWidget extends StatefulWidget {
  const LoctionInputWidget({
    super.key,
    required Function setLocation
  }) : _setLocation = setLocation;

  final Function _setLocation;

  @override
  State<LoctionInputWidget> createState() => _LoctionInputWidgetState();
}

class _LoctionInputWidgetState extends State<LoctionInputWidget> {

  // values
  late String _city;
  late String _state;
  late String _zip;
  // initialize Controllers
  @override
  void initState() {
    super.initState();
    _city = "";
    _state = "";
    _zip = "";

  }

  // update functions
  void _updateCity(String value){
    setState(() {
      _city = value;
    });
  }

    void _updateState(String value){
    setState(() {
      _state = value;
    });
  }

    void _updateZip(String value){
    setState(() {
      _zip = value;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              LocationTextWidget(width: 100, text: "city", updateText: _updateCity),
              LocationTextWidget(width: 75, text: "state", updateText: _updateState),
              LocationTextWidget(width: 100, text: "zip", updateText: _updateZip),
            ],
          ),
          ElevatedButton(onPressed: () {widget._setLocation([_city, _state, _zip]);}, child: Text("Get From Address"))
        ],
      ),
    );
  }
}

class LocationTextWidget extends StatefulWidget {
  const LocationTextWidget({
    super.key,
    required double width,
    required String text,
    required Function updateText
  }): _width = width, _text = text, _updateText = updateText;

  final double _width;
  final String _text;
  final Function _updateText;

  @override
  State<LocationTextWidget> createState() => _LocationTextWidgetState();
}

class _LocationTextWidgetState extends State<LocationTextWidget> {

  // controllers
  late TextEditingController _controller;

  // initialize Controllers
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget._width,
      child: TextField(
        controller: _controller,
        onChanged: (value) => {widget._updateText(value)},
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget._text
      )),
    );
  }
}
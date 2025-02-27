import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/settings_provider.dart';
import 'package:weatherapp/widgets/forecast/forecast_tab_widget.dart';
import 'package:weatherapp/widgets/location/location_tab_widget.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/themes/themes.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ForecastProvider()),
    ChangeNotifierProvider(
        create: (context) => LocationProvider(
            Provider.of<ForecastProvider>(context, listen: false))),
    ChangeNotifierProvider(create: (context) => SettingsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CS492 Weather App';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: title,
      theme: Themes.lightTheme(settingsProvider.lightModeSeedColor),
      darkTheme: Themes.darkTheme(settingsProvider.darkModeSeedColor),
      themeMode: settingsProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        endDrawer: SettingsDrawer(settingsProvider: settingsProvider),
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              SettingsButton()
            ],
            title: Text(widget.title),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.sunny_snowing)),
              Tab(icon: Icon(Icons.edit_location_alt))
            ])),
        body: TabBarView(children: [ForecastTabWidget(), LocationTabWidget()]),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {Scaffold.of(context).openEndDrawer();});
  }
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DarkModeSwitchWidget(settingsProvider: settingsProvider),
          ColorThemePickerWidget()
        ],
      ),
    );
  }
}

class ColorThemePickerWidget extends StatefulWidget {
  const ColorThemePickerWidget({
    super.key,
  });

  @override
  State<ColorThemePickerWidget> createState() => _ColorThemePickerWidgetState();
}

class _ColorThemePickerWidgetState extends State<ColorThemePickerWidget> {
  Color _selectedColor = Color(SettingsProvider.defaultLightModeSeedColor);

  void _setColor(Color value) {
    setState(() {
      _selectedColor = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    _selectedColor = Color(settingsProvider.darkMode ? settingsProvider.darkModeSeedColor : settingsProvider.lightModeSeedColor);

    return ColorPicker(pickerColor: _selectedColor, onColorChanged: (value) {
      _setColor(value);
      settingsProvider.darkMode ? settingsProvider.darkModeSeedColor = value.value : settingsProvider.lightModeSeedColor = value.value;
      // Color.value is deprecated, but it's replacement (Color.toARGB32) is not available in the stable channel yet
    });
  }
}

class DarkModeSwitchWidget extends StatelessWidget {
  const DarkModeSwitchWidget({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.dark_mode),
      title: Text("Dark Mode"),
      trailing: Switch(
        value: settingsProvider.darkMode,
        onChanged: (bool value) => settingsProvider.toggleMode()
      ),
    );
  }
}

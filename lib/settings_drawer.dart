import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<ThemeProvider>(context);

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
          trailing: Switch(
            value: settingsProvider.darkMode,
            onChanged: (value) {
              settingsProvider.updateDarkMode(value);
            },
          ),
        ),
      ]
    );
  }
}

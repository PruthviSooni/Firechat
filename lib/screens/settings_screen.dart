import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static String id = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    bool value = false;
    return Scaffold(
      appBar: AppBar(
          title: Text("Settings"), backgroundColor: Colors.lightBlueAccent),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SwitchListTile(
          value: value,
          onChanged: (v) {
            setState(() {
              value = v;
              if (value == true) {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
              } else {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              }
            });
          },
          title: Text("Toggle To Dark Mode"),
          activeColor: Colors.lightBlueAccent,
          activeTrackColor: Colors.blue,
        ),
      ]),
    );
  }
}

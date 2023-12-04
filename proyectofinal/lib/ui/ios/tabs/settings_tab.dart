import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsTab();
  }
}

class _SettingsTab extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: SettingsList(
        sections: [
          SettingsSection(
              title: const Text('Visual preferences'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  initialValue: false,
                  onToggle: null,
                  title: const Text('Dark Mode'),
                  leading: const Icon(CupertinoIcons.moon),
                ),
                SettingsTile.switchTile(
                  initialValue: false,
                  onToggle: null,
                  title: const Text('Pixel Art Sprites'),
                  leading:
                      const Icon(CupertinoIcons.arrow_right_arrow_left_circle),
                ),
              ]),
        ],
      ),
    ));
  }
}

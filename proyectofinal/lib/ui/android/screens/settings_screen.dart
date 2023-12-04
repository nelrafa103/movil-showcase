import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar_widget.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreen();
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  String selectedOption = 'Dibujado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Settings',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
                title: const Text('Visual preferences'),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    initialValue: false,
                    onToggle: null,
                    title: const Text('Dark Mode'),
                    leading: const Icon(Icons.dark_mode_outlined),
                  ),
                  SettingsTile.switchTile(
                    initialValue: false,
                    onToggle: null,
                    title: const Text('Pixel Art Sprites'),
                    leading: const Icon(Icons.image),
                  ),
                ]),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

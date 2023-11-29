import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';
import 'package:settings_ui/settings_ui.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _settings_screen();
  }
}

class _settings_screen extends State<settings_screen> {
  String selectedOption = 'Dibujado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
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
              title: Text('Visual preferences'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  initialValue: false,
                  onToggle: null,
                  title: Text('Dark Mode'),
                  leading: Icon(Icons.dark_mode_outlined),
                ),

                SettingsTile.switchTile(
                  initialValue: false,
                  onToggle: null,
                  title: Text('Pixel Art Sprites'),
                  leading: Icon(Icons.image),
                ),
            ]),


          ],
        ),
      ),
      bottomNavigationBar: bottom_bar(),
    );
  }

}



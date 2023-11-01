import 'package:flutter/material.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _settings_screen();
  }
}

class _settings_screen extends State<settings_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [],
      ),
      bottomNavigationBar: bottom_bar(),
    );
  }
}

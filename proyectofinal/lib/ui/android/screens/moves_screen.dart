import 'package:flutter/material.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar.dart';

class moves_screen extends StatefulWidget {
  const moves_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _moves_screen();
  }
}

class _moves_screen extends State<moves_screen> {
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

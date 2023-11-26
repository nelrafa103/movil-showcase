import 'package:flutter/material.dart';
import 'package:proyectofinal/ui/android/widgets/bottom_bar_widget.dart';

class MoveScreen extends StatefulWidget {
  const MoveScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoveScreen();
  }
}

class _MoveScreen extends State<MoveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

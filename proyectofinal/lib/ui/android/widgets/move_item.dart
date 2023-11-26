import 'package:flutter/material.dart';

class MoveWidget extends StatefulWidget {
  const MoveWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoveWidget();
  }
}

class _MoveWidget extends State<MoveWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(""),
                  Text(""),
                ],
              ),
              TextButton(onPressed: () => {}, child: Text("")),
            ],
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}

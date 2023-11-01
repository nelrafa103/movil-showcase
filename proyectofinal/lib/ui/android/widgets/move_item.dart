import 'package:flutter/material.dart';

class move_item extends StatefulWidget {
  const move_item({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _move_item();
  }
}

class _move_item extends State<move_item> {
  @override
  Widget build(BuildContext context) {
    return  Card(
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

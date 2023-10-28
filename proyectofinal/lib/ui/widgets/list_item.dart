import 'package:flutter/material.dart';

class list_item extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _list_item();
  }
}

class _list_item extends State<list_item> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Column(
          children: [
            Icon(Icons.favorite_border),
          ],
        ),
        Column(
          children: [
            Image.network(
              'https://picsum.photos/250?image=9',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ],
    ));
  }
}

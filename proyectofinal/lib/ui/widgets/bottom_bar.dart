import 'package:flutter/material.dart';

class bottom_bar extends StatefulWidget {
  const bottom_bar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _bottom_bar();
  }
}

class _bottom_bar extends State<bottom_bar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BottomAppBar(
      child: Container(
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(onPressed: () => {}, icon: Icon(Icons.settings)),
              IconButton(onPressed: () => {}, icon: Icon(Icons.home)),
              IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.cast_for_education_rounded)),
              IconButton(onPressed: () => {}, icon: Icon(Icons.search))
            ]),
      ),
    );
    // throw UnimplementedError();
  }
}

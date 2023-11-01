import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class bottom_bar extends StatefulWidget {
  const bottom_bar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _bottom_bar();
  }
}

class _bottom_bar extends State<bottom_bar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<String> routes = ["/", "/habilidades", "/busqueda", "/configuracion"];
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          print(routes[index]);
          context.go(routes[index]);
          //GoRouter.of(context).go(routes[index]);
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Inicio'),
        NavigationDestination(
            selectedIcon: Icon(Icons.shield),
            icon: Icon(Icons.shield_outlined),
            label: 'Habilidades'),
        NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Buscar'),
        NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Configuración'),
      ],
    );
    // throw UnimplementedError();
  }
}

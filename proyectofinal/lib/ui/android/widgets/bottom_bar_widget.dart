import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/states/app_state.dart';
import 'package:proyectofinal/states/cubit/app_cubit.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomBar();
  }
}

class _BottomBar extends State<BottomBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> routes = ["/", "/habilidades", "/busqueda", "/configuracion"];
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state is AppLoaded) {
        currentPageIndex = state.index;
        return NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              BlocProvider.of<AppCubit>(context).changeTab(index);
              context.go(routes[index]);
              if (index == 0) {
                context.read<PokemonsCubit>().fetch();
              }
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
                //   enabled: false,
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: 'Configuración'),
          ],
        );
      }
      return Container();
    });
  }
}

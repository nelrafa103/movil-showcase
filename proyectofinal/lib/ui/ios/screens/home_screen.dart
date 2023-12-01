import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/ui/ios/tabs/abilities_tab.dart';
import 'package:proyectofinal/ui/ios/tabs/home_tab.dart';
import 'package:proyectofinal/ui/ios/tabs/search_tab.dart';
import 'package:proyectofinal/ui/ios/tabs/settings_tab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(String s, {super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shield),
            label: 'Abilities',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return BlocProvider(
            create: (context) => PokemonsCubit()..fetch(),
            child: CupertinoTabView(
              builder: (BuildContext context) {
                switch (index) {
                  case 0:
                    //   Navigator.of(context).pushNamed("/");
                    return HomeTab();
                  case 1:
                    return BlocProvider(
                        create: (context) => AbilitiesCubit()..fetch(),
                        child: AbilitiesTab());
                  case 2:
                    return const SearchTab();
                  case 3:
                    return SettingsTab();
                  default:
                    return const SearchTab();
                }
              },
            ));
      },
    );
  }
}

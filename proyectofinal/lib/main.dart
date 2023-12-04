import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/router.dart';
import 'package:proyectofinal/hive.dart';
import 'package:proyectofinal/states/cubit/app_cubit.dart';
import 'package:proyectofinal/states/cubit/abilities_cubit.dart';
import 'package:proyectofinal/states/cubit/pokemon_cubit.dart';
import 'package:proyectofinal/states/cubit/pokemons_cubit.dart';
import 'package:proyectofinal/ui/android/screens/pokemon_detail_screen.dart';
import 'package:proyectofinal/ui/ios/screens/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:proyectofinal/ui/ios/tabs/pokemon_detail_tab.dart';

void main() {
  runApp(const MyApp());
  DbInitializer.initialize();

  // await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isMacOS) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PokemonsCubit()..fetch(),
              ),
              BlocProvider(
                create: (context) => PokemonCubit(),
              ),
              BlocProvider(
                create: (context) => AbilitiesCubit()..fetch(),
              ),
            ],
            child: CupertinoApp(
              routes: {
                "/": (_) => const MyHomePage("", title: ""),
                "/detalle": (_) => const PokemonDetailTab(),
              },
              debugShowCheckedModeBanner: false,
            ));
      }
    }
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PokemonsCubit()..fetch(),
          ),
          BlocProvider(
            create: (context) => PokemonCubit(),
          ),
          BlocProvider(
            create: (context) => AbilitiesCubit()..fetch(),
          ),
          BlocProvider(
            create: (context) => AppCubit()..changeTab(0),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ));
  }
}
